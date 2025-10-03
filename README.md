```bash
# In host machine 
git clone https://github.com/isaac-sim/IsaacLab.git
./src/IsaacLab/docker/container.py start ros2

./src/IsaacLab/docker/container.py enter ros2
# In container
isaaclab -p scripts/reinforcement_learning/rsl_rl/play.py --task Isaac-Velocity-Rough-G1-v0 --use_pretrained_checkpoint

git clone https://github.com/Renkunzhao/rl_ws.git
cd docker
docker compose --env-file .env up -d --build
docker exec -it rl_ws bash

# In container
cd /workspace/rl_ws
./scripts/config.sh
```

```bash
python src/unitree_rl_lab/scripts/list_envs.py

python src/unitree_rl_lab/scripts/rsl_rl/train.py --headless --task Unitree-G1-29dof-Velocity
python src/unitree_rl_lab/scripts/rsl_rl/play.py --task Unitree-G1-29dof-Velocity 

python src/unitree_rl_lab/scripts/rsl_rl/train.py --headless --task Unitree-Go2-Velocity

python src/unitree_rl_lab/scripts/rsl_rl/train.py --headless --task Unitree-Go2-Velocity --resume --load_run 2025-10-03_02-33-14 --checkpoint model_1700.pt
```