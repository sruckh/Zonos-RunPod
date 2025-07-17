# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

- Install dependencies: uv sync
- Install with compile extras: uv sync --extra compile
- Run Gradio interface: uv run gradio_interface.py
- Run sample script: uv run sample.py
- Docker build: docker build -t zonos .
- Docker run: docker run -it --gpus=all --net=host -v /path/to/Zonos:/Zonos -t zonos
- Docker compose: docker compose up

## High-Level Architecture

Zonos is a text-to-speech model with a modular architecture:
- **Core Model (zonos/model.py)**: Zonos class integrates autoencoder (DAC for code generation/decoding), backbone (transformer or hybrid with Mamba SSM), and prefix conditioner for inputs like text phonemes, speaker embeddings, emotions.
- **Backbones (zonos/backbone/)**: Pure Torch transformer (_torch.py) or Mamba SSM hybrid (_mamba_ssm.py) for sequence modeling.
- **Conditioning (zonos/conditioning.py)**: Processes text to phonemes via Espeak, handles conditioners for emotions, pitch, rate; make_cond_dict prepares dict for model input.
- **Generation**: Autoregressive sampling from logits, with optional CUDA graphs for efficiency.
- **Interface (gradio_interface.py)**: Gradio UI for model interaction, loading models, generating audio with conditioning params.
- **Configs (zonos/config.py)**: Dataclasses for model and inference parameters.

The model generates speech codes from conditioned inputs, decodes to audio at 44kHz, supporting multilingual TTS, voice cloning, and emotion control.