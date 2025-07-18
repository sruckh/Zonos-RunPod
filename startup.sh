#!/bin/bash
set -e

echo "🚀 Starting Zonos RunPod initialization..."

# Install build dependencies first
echo "🔧 Installing build dependencies..."
pip3 install --upgrade setuptools wheel build

# Install PyTorch with CUDA 12.8 support first
echo "📦 Installing PyTorch with CUDA 12.8 support..."
pip3 install torch==2.6.0 torchvision torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu128

# Install Flash Attention with correct CUDA/PyTorch compatibility
echo "⚡ Installing Flash Attention..."
pip3 install https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.1/flash_attn-2.8.1+cu12torch2.6cxx11abiFALSE-cp310-cp310-linux_x86_64.whl

# Install remaining project dependencies
echo "📋 Installing project dependencies..."
# First sync base dependencies to create the environment
uv sync
# Then install build tools in the created environment
uv pip install setuptools wheel build
# Finally install compile extras
uv sync --extra compile

echo "✅ Initialization complete. Starting Gradio interface..."

# Start the application
exec python3 gradio_interface.py