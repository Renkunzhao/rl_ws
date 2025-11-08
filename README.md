```bash
# In host machine 
git clone https://github.com/Renkunzhao/IsaacLab.git
./docker/container.py start ros2

./docker/container.py enter ros2
# In container
isaaclab -p scripts/reinforcement_learning/rsl_rl/play.py --task Isaac-Velocity-Rough-G1-v0 --use_pretrained_checkpoint

git clone https://github.com/Renkunzhao/rl_ws.git
cd docker
docker compose --env-file .env up -d --build
docker exec -it rl_ws bash

# In container
cd /workspace/rl_ws
./scripts/unitree-config.sh
```
