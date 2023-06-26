#!/bin/env bash
#SBATCH --partition=public-gpu
#SBATCH --time=2-00:00:00
#SBATCH --output=Pascal-%j.out
#SBATCH --mem=24GB
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1,VramPerGpu:24G

module load fosscuda/2020b Python/3.8.6
source ~/Kraken-env/bin/activate
pip install albumentations

work_directory="/home/users/j/jacsont/Docteur_Pascal/SEG/Model_SEG_4"
mkdir -p ${work_directory}
cd ${work_directory}

OUTPUT_NAME="Model_SEG_1"

XML_FOLDER="/home/users/j/jacsont/Docteur_Pascal/Data/Zola_Pascal"
echo "KETOS training"
srun ketos segtrain  -d cuda:0  -f alto "${XML_FOLDER}/*.xml"
