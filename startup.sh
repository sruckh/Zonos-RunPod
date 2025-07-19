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

# Install Flash Attention with correct CUDA/PyTorch compatibility
echo "⚡ Installing Flash Attention..."
# Use the cu12 wheel for CUDA 12.x compatibility
pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.1/flash_attn-2.8.1+cu12torch2.6cxx11abiFALSE-cp311-cp311-linux_x86_64.whl

# Install mamba-ssm and causal-conv1d
echo "🔧 Installing mamba-ssm and causal-conv1d..."
# Try to use pre-built wheels by ensuring setuptools is up to date
pip install --upgrade pip setuptools wheel
# Install with no build isolation to use system packages
pip install --no-build-isolation mamba-ssm==2.2.5
pip install --no-build-isolation causal-conv1d==1.5.2

# Install all other dependencies from pyproject.toml
echo "📋 Installing project dependencies..."
pip install .

echo "✅ Initialization complete. Starting Gradio interface..."

# Start the application
exec python3 gradio_interface.py