#!/bin/bash
set -e

echo "🚀 Starting Zonos RunPod initialization..."

# Install compile-time dependencies first (as pre-compiled wheels from PyPI)
echo "🔧 Installing compile-time dependencies..."
pip install mamba-ssm==2.2.4
pip install causal-conv1d==1.5.0.post8

# Install Flash Attention with correct CUDA/PyTorch compatibility
echo "⚡ Installing Flash Attention..."
pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.1/flash_attn-2.8.1+cu12torch2.6cxx11abiFALSE-cp310-cp310-linux_x86_64.whl

# Install all other dependencies from pyproject.toml
echo "📋 Installing project dependencies..."
pip install .

echo "✅ Initialization complete. Starting Gradio interface..."

# Start the application
exec python3 gradio_interface.py