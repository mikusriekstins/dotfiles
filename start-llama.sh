#!/bin/bash

# start
exec distrobox enter llama-rocm-7.2 -- llama-server \
  -m  ~/.lmstudio/models/unsloth/Qwen3-Coder-Next-GGUF/Qwen3-Coder-Next-Q4_0.gguf \
  --host   0.0.0.0 \
  --port   8080 \
  -ngl 99 \
  -c  64000

