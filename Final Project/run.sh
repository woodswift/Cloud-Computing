export START=$(date +%s)
../../tools/launch.py -n 2 -H hosts python train_mnist.py --kv-store dist_sync
export END=$(date +%s)
echo $((END -START)) >> log.txt
