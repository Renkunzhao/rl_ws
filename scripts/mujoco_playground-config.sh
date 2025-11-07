#!/bin/bash

# 获取项目根目录
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src

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
uv pip install onnxruntime hidapi
uv pip install jupyter notebook
./.venv/bin/python -c "import mujoco_playground"
