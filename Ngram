import java.io.IOException;
import java.util.*;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

public class Ngram {
	//size stores the variable meaning the size of n-gram
	private static int size;

	public static void setSize(int n) {
		size=n;
	}

	public static int getSize() {
		return size;
	}
		
	//changes to Map class and function are noted
	public static class NgramMapper extends Mapper<Object, Text, Text, IntWritable> {
		private final static IntWritable one = new IntWritable(1);
		private Text word = new Text();
		
		//Method to generate n-gram sequence
		public static List<String> ngrams(String str, int n) {
	        List<String> ngrams = new ArrayList<String>();
	        for (int i=0; i<str.length()-n+1; i++)
	            ngrams.add(str.substring(i, i+n));
	        return ngrams;
	    }
		
		//n-gram map Method
		public void map(Object key, Text value, Context context)
				throws IOException, InterruptedException {	
			int n=getSize();
			List<String> itr = ngrams(value.toString(), n);
			//walk through n-gram sequence
			for(int i=0; i<itr.size();i++) {
				word.set(itr.get(i));
				context.write(word, one);
			}
		}
	}
	
	//no changes to Reduce class and function
	public static class IntSumReducer extends Reducer<Text,IntWritable,Text,IntWritable> {
		private IntWritable result = new IntWritable();
		public void reduce(Text key, Iterable<IntWritable> values, Context context)
				throws IOException, InterruptedException {
			int sum = 0;
			for (IntWritable val : values) {
				sum += val.get();
			}
			result.set(sum);
			context.write(key, result);
		}
	}
	
	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
		if (otherArgs.length < 3) {
			System.err.println("Usage: wordcount <in> [<in>…] <out> N");
			System.exit(2);
		}
		setSize(Integer.parseInt(otherArgs[2]));
		System.out.println(getSize() + "-gram started!");
		Job job = Job.getInstance(conf, "n-gram");
		job.setJarByClass(Ngram.class);
		job.setMapperClass(NgramMapper.class);
		job.setCombinerClass(IntSumReducer.class);
		job.setReducerClass(IntSumReducer.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}
