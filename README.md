```bash
# In host machine 
git clone https://github.com/isaac-sim/IsaacLab.git
./src/IsaacLab/docker/container.py start ros2

git clone https://github.com/Renkunzhao/rl_ws.git
cd docker
docker compose --env-file .env up -d --build

# In container
cd /workspace/rl_ws
./scripts/config.sh
```