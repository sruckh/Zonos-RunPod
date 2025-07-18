#!/bin/bash
set -e

echo "🚀 Starting Zonos RunPod initialization..."

# Install build dependencies first
echo "🔧 Installing build dependencies..."
pip3 install --upgrade setuptools wheel build

# Install PyTorch with CUDA 12.8 support first
echo "📦 Installing PyTorch with CUDA 12.8 support..."
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128

# Install Flash Attention with correct CUDA/PyTorch compatibility
echo "⚡ Installing Flash Attention..."
pip3 install https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.1/flash_attn-2.8.1+cu12torch2.7cxx11abiFALSE-cp311-cp311-linux_x86_64.whl

# Install remaining project dependencies
echo "📋 Installing project dependencies..."
# Install setuptools in the uv environment first
uv add setuptools wheel build
uv sync --extra compile

echo "✅ Initialization complete. Starting Gradio interface..."

# Start the application
exec python3 gradio_interface.py