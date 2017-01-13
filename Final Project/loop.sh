for((i = 400; i <= 2000; ))
do
	tc qdisc del dev eth0 root
	tc qdisc add dev eth0 root tbf rate ${i}mbit latency 50ms burst 10000
	ssh root@10.0.2.5 "tc qdisc del dev eth0 root;"
	ssh root@10.0.2.5 "tc qdisc add dev eth0 root tbf rate ${i}mbit latency 50ms burst 10000;"
	echo "apply ${i}mbit" >> log.txt
	./run.sh
	i=$((${i}+400))
done;
