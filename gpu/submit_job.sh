#!/bin/bash
#
#SBATCH --mail-user=kchow1@uchicago.edu
#SBATCH --mail-type=ALL
#SBATCH --output=$(pwd)/%j.%N.stdout
#SBATCH --error=$(pwd)/%j.%N.stderr
#SBATCH --chdir=$(pwd)
#SBATCH --partition=gpu-all
#SBATCH --gres=gpu:1
#SBATCH --job-name=hw2_job

export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib

make
./grayscale test_img.png test_img_out.png
