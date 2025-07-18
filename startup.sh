#!/bin/bash
set -e

echo "🚀 Starting Zonos RunPod initialization..."

# Install all dependencies from pyproject.toml
echo "📋 Installing project dependencies..."
pip install .

# Install compile-time dependencies
echo "🔧 Installing compile-time dependencies..."
pip install .[compile]

# Install Flash Attention with correct CUDA/PyTorch compatibility
echo "⚡ Installing Flash Attention..."
pip3 install https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.1/flash_attn-2.8.1+cu12torch2.6cxx11abiFALSE-cp310-cp310-linux_x86_64.whl

echo "✅ Initialization complete. Starting Gradio interface..."

# Start the application
exec python3 gradio_interface.py