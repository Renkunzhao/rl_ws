#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src

# Unitree RL Lab
cd $PROJECT_DIR/src
git clone https://github.com/unitreerobotics/unitree_rl_lab.git
isaaclab -p -m pip install -e src/unitree_rl_lab/source/unitree_rl_lab

# Unitree Model
cd $PROJECT_DIR/src
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
sudo apt-get install git-lfs
git lfs install
git clone https://huggingface.co/datasets/unitreerobotics/unitree_model

