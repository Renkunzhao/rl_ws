#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/lib

# Install Mujoco
cd $PROJECT_DIR/lib
git clone https://github.com/google-deepmind/mujoco.git -b 3.2.7
cd mujoco
mkdir build 
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)
make install

# Unitree SDK2
cd $PROJECT_DIR/lib
git clone https://github.com/unitreerobotics/unitree_sdk2.git
cd unitree_sdk2
mkdir build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)
make install
