#!/bin/bash
cd /benchmark

#load hyperparameters
#BENCH_RCP is defined by bench_rcp.conf
#this reference convergence point (RCP) should not be modified
source /benchmark/bench_rcp.conf

export local_batch_size=2
export DATADIR="/data/mini"
export output_dir=/workspace/output_dir
export run_tag="deepcam-mini-1"
export MAX_EPOCHS=64
export MAX_INTER_THREADS=1

python3 /opt/deepCam/train.py \
     ${BENCH_RCP_BASELINE} \
    --wireup_method "nccl-slurm" \
    --run_tag ${run_tag} \
    --data_dir_prefix $DATADIR \
    --output_dir ${output_dir} \
    --model_prefix "segmentation" \
    --optimizer "AdamW" \
    --max_epochs $MAX_EPOCHS \
    --max_inter_threads $MAX_INTER_THREADS \
    --local_batch_size ${local_batch_size}

