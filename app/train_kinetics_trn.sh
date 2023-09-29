echo "in train_kinetics_trn.sh"

#export MALLOC_ARENA_MAX=32
XLA_USE_BF16=1 NEURON_CC_FLAGS='--retry_failed_compilation --internal-max-instruction-limit=10000000 --enable-experimental-O1 --internal-build-with-users --enable-saturate-infinity' torchrun --nproc_per_node=32 train_trn.py \
  --config_file_path config/main.yaml \
  --dataset kinetics-small \
  --num_workers 2 \
  --log_steps 4 \
  --num_epochs 1 \
  --batch_size 1 \
  --max_steps 1000 \
  --lr 1e-5
