#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/lib
mkdir -p $PROJECT_DIR/src

# Install Mujoco
cd $PROJECT_DIR/lib
git clone https://github.com/google-deepmind/mujoco.git -b 3.2.7
cd mujoco
mkdir build 
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)
sudo make install

# Unitree SDK2
cd $PROJECT_DIR/lib
git clone https://github.com/unitreerobotics/unitree_sdk2.git
cd unitree_sdk2
git checkout c8a71e281093593f4dcc7bceb3b3b529ff0e36b4
mkdir build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)
make install

# Unitree ROS2 & Unitree Sdk2 Bridge
cd $PROJECT_DIR/lib
git clone https://github.com/unitreerobotics/unitree_ros2 -b v0.3.0
git clone https://github.com/Renkunzhao/unitree_sdk2_bridge.git
cd $PROJECT_DIR
ROS_DISTRO=humble
ROS_SETUP="/opt/ros/$ROS_DISTRO/setup.bash"
if [ -f "$ROS_SETUP" ]; then
    echo "ROS 2 ($ROS_DISTRO) installation found ✅"
    # colcon build --packages-select unitree_sdk2 unitree_mujoco --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    source "$ROS_SETUP"
    colcon build --packages-select unitree_api unitree_go unitree_hg --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    source install/setup.bash
    colcon build --packages-select unitree_sdk2_bridge --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
else
    echo "ROS 2 not installed ❌ Skipping ROS 2 build."
fi

# Unitree Model
cd $PROJECT_DIR/lib
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
apt-get install git-lfs
git lfs install
git clone https://huggingface.co/datasets/unitreerobotics/unitree_model

# Unitree Mujoco
cd $PROJECT_DIR/src
git clone https://github.com/Renkunzhao/unitree_mujoco.git
cd unitree_mujoco/simulate
mkdir build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)

# Unitree RL Lab
cd $PROJECT_DIR/src
git clone https://github.com/Renkunzhao/unitree_rl_lab.git
/workspace/isaaclab/_isaac_sim/python.sh -m pip install -e unitree_rl_lab/source/unitree_rl_lab

# Compile the robot_controller
cd $PROJECT_DIR/src/unitree_rl_lab/deploy/robots/g1_29dof
mkdir build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)

cd $PROJECT_DIR/src/unitree_rl_lab/deploy/robots/go2
mkdir build
cd build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
make -j$(nproc)

cd $PROJECT_DIR
jq -s 'add' $(find . -name compile_commands.json) > build/compile_commands.json