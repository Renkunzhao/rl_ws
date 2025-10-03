#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src
cd $PROJECT_DIR/src

# Clone Repo
# Unitree ROS2
cd $PROJECT_DIR/src
git clone https://github.com/unitreerobotics/unitree_ros2 -b v0.3.0

# build
cd $PROJECT_DIR
source /opt/ros/humble/setup.bash
colcon build --packages-select unitree_api unitree_go unitree_hg --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cd $PROJECT_DIR
jq -s 'add' $(find . -name compile_commands.json) > build/compile_commands.json