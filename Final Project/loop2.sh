for((i = 10; i <= 100; ))
do
	tc qdisc del dev eth0 root
	tc qdisc add dev eth0 root netem deley ${i}ms
	ssh root@10.0.2.5 "tc qdisc del dev eth0 root;"
	ssh root@10.0.2.5 "tc qdisc add dev eth0 root netem deley ${i}ms;"
	echo "apply ${i}ms for deley" >> log.txt
	./run.sh
	i=$((${i}+10))
done;
