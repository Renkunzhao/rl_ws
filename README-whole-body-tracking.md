```bash
cd src/whole_body_tracking
python scripts/csv_to_npz.py --input_file /workspace/rl_ws/lib/LAFAN1_Retargeting_Dataset/g1/jumps1_subject1.csv --input_fps 30 --output_name LAFAN1-g1-jumps1_subject1 --headless

python scripts/replay_npz.py --registry_name=kzren-UW-Madison/wandb-registry-motions/LAFAN1-g1-jumps1_subject1

python scripts/rsl_rl/train.py --task=Tracking-Flat-G1-v0 \
--registry_name kzren-UW-Madison/wandb-registry-motions/LAFAN1-g1-jumps1_subject1 \
--headless --logger wandb --log_project_name WBT --run_name LAFAN1-g1-jumps1_subject1
```