#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src

# Unitree Model
cd $PROJECT_DIR/src
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

# Mujoco playground
cd $PROJECT_DIR/src
git clone https://github.com/google-deepmind/mujoco_playground.git

cd $PROJECT_DIR/src/mujoco_playground
wget -qO- https://astral.sh/uv/install.sh | sh
echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
source $HOME/.local/bin/env
rm -rf .venv
uv venv --python 3.11 # replace
source .venv/bin/activate
uv pip install -U "jax[cuda12]"    
./.venv/bin/python -c "import jax; print(jax.default_backend())"
uv pip install -e ".[all]"
uv pip install tensorboard
./.venv/bin/python -c "import mujoco_playground"
