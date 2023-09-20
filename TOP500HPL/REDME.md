# NGC HPL

The script `run-hpl.slurm` is a basic script to run NVIDIA's HPL container on H100 GPUs. The script `max_gpu_app_clocks.sh` is invoked by the `run-hpl.slurm` to set the GPU clock frequencies to the maximum before the hpl run and reset them afterwards.  

## Notes:
- To run the container, enroot needs to be configured to connect to NGC using your credentials. 
  ```shell
  mkdir -p ~/.config/enroot
  echo "machine nvcr.io login \$oauthtoken password <your specific oauthtoken password for nvcr.io>" > ~/.config/enroot/.credentials 
  ```
  - [To setup your nvcr.io key](https://www.pugetsystems.com/labs/hpc/How-To-Setup-NVIDIA-Docker-and-NGC-Registry-on-your-Workstation---Part-4-Accessing-the-NGC-Registry-1115)
  - Current version is not intended to be optimal. 
