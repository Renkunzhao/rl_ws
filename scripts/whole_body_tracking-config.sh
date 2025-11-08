#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/lib
mkdir -p $PROJECT_DIR/src

# Install whole_body_tracking
cd $PROJECT_DIR/src
git clone https://github.com/HybridRobotics/whole_body_tracking.git
cd whole_body_tracking
curl -L -o unitree_description.tar.gz https://storage.googleapis.com/qiayuanl_robot_descriptions/unitree_description.tar.gz && \
tar -xzf unitree_description.tar.gz -C source/whole_body_tracking/whole_body_tracking/assets/ && \
rm unitree_description.tar.gz

/workspace/isaaclab/_isaac_sim/python.sh -m pip install -e source/whole_body_tracking

cd $PROJECT_DIR
jq -s 'add' $(find . -name compile_commands.json) > build/compile_commands.json