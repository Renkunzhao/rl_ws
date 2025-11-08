#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/lib
mkdir -p $PROJECT_DIR/src

# Install LAFAN1_Retargeting_Dataset
cd $PROJECT_DIR/lib
git clone https://huggingface.co/datasets/lvhaidong/LAFAN1_Retargeting_Dataset

uv venv --python 3.10
source .venv/bin/activate

uv pip install scipy pin numpy rerun-sdk==0.22.0 trimesh
