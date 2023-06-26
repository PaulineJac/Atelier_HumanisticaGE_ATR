#!/bin/env bash
#SBATCH --partition=public-gpu
#SBATCH --time=2-00:00:00
#SBATCH --output=kraken_Pascal-%j.out
#SBATCH --mem=24GB
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1,VramPerGpu:24G

module load fosscuda/2020b Python/3.8.6
source ~/kraken-env/bin/activate


work_directory="~/Docteur_Pascal/HTR/Model_1"
mkdir -p ${work_directory}
cd ${work_directory}

OUTPUT_NAME="Pascal"
XML_FOLDER="~/Docteur_Pascal/Data/Zola_Pascal"
echo "KETOS training"

ketos train --augment --workers 8 -d cuda:0 --min-epochs 40 -w 0 -s '[1,120,0,1 Cr3,13,32 Do0.1,2 Mp2,2 Cr3,13,32 Do0.1,2 Mp2,2 Cr3,9,64 Do0.1,2 Mp2,2 Cr3,9,64 Do0.1,2 S1(1x0)1,3 Lbx200 Do0.1,2 Lbx200 Do.1,2 Lbx200 Do]' -r 0.0001 -f xml "${XML_FOLDER}/*.xml"
