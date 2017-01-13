for((i = 1; i <= 5; ))
do
	tc qdisc del dev eth0 root
	tc qdisc add dev eth0 root netem loss ${i}%
	ssh root@10.0.2.5 "tc qdisc del dev eth0 root;"
	ssh root@10.0.2.5 "tc qdisc add dev eth0 root netem loss ${i}%;"
	echo "apply ${i} percentage for loss" >> log.txt
	./run.sh
	i=$((${i}+1))
done;
