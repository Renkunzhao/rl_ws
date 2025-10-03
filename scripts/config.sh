#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src

# Unitree Model
cd $PROJECT_DIR/src
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
sudo apt-get install git-lfs
git lfs install
git clone https://huggingface.co/datasets/unitreerobotics/unitree_model

# Unitree RL Lab
cd $PROJECT_DIR/src
git clone https://github.com/unitreerobotics/unitree_rl_lab.git
/workspace/isaaclab/_isaac_sim/python.sh -m pip install -e unitree_rl_lab/source/unitree_rl_lab
# Compile the robot_controller
cd unitree_rl_lab/deploy/robots/g1_29dof # or other robots
mkdir build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)

# Unitree Mujoco
cd $PROJECT_DIR/src
git clone https://github.com/Renkunzhao/unitree_mujoco.git
cd unitree_mujoco/simulate
mkdir build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)