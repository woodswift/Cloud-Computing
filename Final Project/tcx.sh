#!/bin/bash

tc qdisc del dev eth0 root;
tc qdisc add dev eth0 root tbf rate ${1}mbit latency 10ms burst 10000;
echo apply ${1}mbit. 
