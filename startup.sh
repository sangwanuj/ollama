#!/usr/bin/env bash
set -euo pipefail

# Install downloader if missing
apt-get update    || true
apt-get install -y wget || true

# Prepare workspace
mkdir -p /workspace
cd /workspace

# Launch HTTP server in background
nohup python3 -m http.server 8000 >http.log 2>&1 &

# Fetch and launch your manager.py
wget -qO manager.py https://admin.pyqapp.com/api/manager.py
nohup python3 manager.py >output.log 2>&1 &

# Now hand off to Ollama's native entrypoint and keep it in the foreground
exec ollama serve --port 11434
