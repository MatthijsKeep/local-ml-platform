#!/bin/bash
# 1. Reset: Ensure we start from a clean slate
podman machine stop || true
podman machine rm -f || true

# 2. Provision: Allocate resources
# --cpus 4: Python ML libraries (PyTorch/NumPy) parallelize data loading. 
#           Less than 4 CPUs will bottleneck your data pipeline.
# --memory 12288: (12GB) ML models + Kubernetes Overhead (~2GB) + Java apps (like Jenkins/Spark). 
#                 8GB is tight; 12GB is comfortable for an M4. 8GB for now.
# --disk-size 50: Docker images for ML (NVIDIA/PyTorch) are huge (often 5-10GB each). 
#                 Default disk space fills up in days.
podman machine init --cpus 4 --memory 8888 --disk-size 50

# 3. Power On
podman machine start