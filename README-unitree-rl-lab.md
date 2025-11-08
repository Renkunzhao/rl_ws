```bash
python src/unitree_rl_lab/scripts/list_envs.py

python src/unitree_rl_lab/scripts/rsl_rl/train.py --headless --task Unitree-G1-29dof-Velocity
python src/unitree_rl_lab/scripts/rsl_rl/play.py --task Unitree-G1-29dof-Velocity 

python src/unitree_rl_lab/scripts/rsl_rl/train.py --headless --task Unitree-Go2-Velocity

python src/unitree_rl_lab/scripts/rsl_rl/train.py --headless --task Unitree-Go2-Velocity --resume --load_run 2025-10-03_02-33-14 --checkpoint model_1700.pt
```