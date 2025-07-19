#!/bin/bash
set -e

echo "🚀 Starting Zonos RunPod initialization..."

# Install PyTorch with CUDA 12.6 support first
echo "🔦 Installing PyTorch with CUDA 12.6 support..."
pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu126


# Install Flash Attention with correct CUDA/PyTorch compatibility
echo "⚡ Installing Flash Attention..."
pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.1/flash_attn-2.8.1+cu12torch2.6cxx11abiFALSE-cp311-cp311-linux_x86_64.whl

# Install all other dependencies from pyproject.toml
echo "📋 Installing project dependencies..."
pip install .

echo "✅ Initialization complete. Starting Gradio interface..."

# Start the application
exec python3 gradio_interface.py