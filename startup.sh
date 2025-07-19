#!/bin/bash
set -e

echo "🚀 Starting Zonos RunPod initialization..."

# Check for GPU availability
echo "🔍 Checking GPU availability..."
if nvidia-smi > /dev/null 2>&1; then
    echo "✅ GPU detected:"
    nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv,noheader
else
    echo "⚠️ WARNING: No GPU detected! The container should be run with '--gpus all' flag"
    echo "   Example: docker run --gpus all -p 7860:7860 zonos-runpod"
fi

# The base image already has PyTorch 2.6.0+cu124 installed
# We'll work with CUDA 12.4, not 12.6

# Try to install optional compile dependencies
echo "🔧 Installing optional compile dependencies..."
# Upgrade pip and setuptools first
pip install --upgrade pip setuptools wheel

# Install Flash Attention with correct CUDA/PyTorch compatibility
echo "⚡ Installing Flash Attention..."
# Use v2.7.4.post1 which is compatible with PyTorch 2.6, Python 3.11, CUDA 12.x
pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.7.4.post1/flash_attn-2.7.4.post1+cu12torch2.6cxx11abiFALSE-cp311-cp311-linux_x86_64.whl

echo "📦 Attempting to install mamba-ssm..."
pip install mamba-ssm==2.2.5 || echo "   Mamba-SSM installation failed - transformer models will still work"

echo "📦 Attempting to install causal-conv1d..."  
pip install causal-conv1d==1.5.2 || echo "   Causal-conv1d installation failed - transformer models will still work"

# Install all other dependencies from pyproject.toml
echo "📋 Installing project dependencies..."
pip install .

echo "✅ Initialization complete. Starting Gradio interface..."

# Start the application
exec python3 gradio_interface.py