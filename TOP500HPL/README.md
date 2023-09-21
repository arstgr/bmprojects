# NGC HPL

The script `run-hpl.slurm` is a basic script to run NVIDIA's HPL container on H100 GPUs. The script `max_gpu_app_clocks.sh` is invoked by the `run-hpl.slurm` to set the GPU clock frequencies to the maximum before the hpl run and reset them afterwards.  

## Notes:
  - Current version is not intended to be optimal. 
