#!/bin/bash

# ==============================================================================
# COLIMA (PODMAN) + MINIKUBE SETUP FOR APPLE SILICON (M4)
# ==============================================================================
# Architecture: Minikube -> (Socket) -> Colima [Podman Runtime + Rosetta 2]
# We use the 'docker' driver in Minikube because it is more stable on macOS
# and communicates perfectly with Podman's Docker-compatible socket.
# ==============================================================================

set -e  # Exit on error

echo "🚀 Setting up Colima (Podman) + Minikube for Apple Silicon..."

# 1. Stop and clean existing instances
echo "🧹 Cleaning existing instances..."
minikube delete 2>/dev/null || true
colima stop 2>/dev/null || true

# 2. Start Colima with PODMAN runtime and Rosetta 2 emulation
# --runtime podman: Switches from Docker to Podman
# --vz-rosetta: Enables high-performance x86 emulation for AMD64 images
echo "📦 Starting Colima with Podman runtime..."
colima start \
  --runtime podman \
  --cpu 4 \
  --memory 12 \
  --disk 50 \
  --arch aarch64 \
  --vm-type vz \
  --vz-rosetta \
  --mount-type virtiofs \
  --network-address

# 3. Configure Environment Variables
# Point Docker client (and Minikube) to Colima's Podman socket
# Colima usually links this automatically, but we set it explicitly for safety.
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

echo "🔌 Socket set to: $DOCKER_HOST"

# 4. Verify Podman is active and emulating AMD64
echo "🔍 Testing Podman + Rosetta 2..."
# Note: We use 'docker' command here which now talks to Podman socket
if docker run --rm --platform linux/amd64 alpine uname -m | grep -q "x86_64"; then
    echo "✅ AMD64 emulation working via Rosetta 2 (on Podman)"
else
    echo "❌ AMD64 emulation failed - check Colima setup"
    exit 1
fi

# 5. Start Minikube
# We use --driver=docker because Podman provides a Docker-compatible API.
# This prevents the experimental issues often found with --driver=podman on macOS.
echo "🎯 Starting Minikube..."
minikube start \
  --driver=docker \
  --container-runtime=containerd \
  --cpus=4 \
  --memory=8192 \
  --disk-size=50g \
  --extra-config=kubelet.housekeeping-interval=10s

# 6. Enable essential add-ons
echo "📦 Enabling Ingress Controller..."
minikube addons enable ingress
echo "📊 Enabling Metrics Server..."
minikube addons enable metrics-server

# 7. Display cluster info
echo ""
echo "✅ Minikube cluster ready (Running on Podman via Colima)!"
echo "🔍 Runtime Info: $(docker info | grep 'Server Version')" 
echo "🌐 Colima Status: $(colima status)"
echo "📍 Dashboard: minikube dashboard"
echo ""
echo "💡 Tips:"
echo "   - Since you are using Podman, you may need to start services rootless."
echo "   - To use the docker CLI with this setup: export DOCKER_HOST=\"unix://${HOME}/.colima/default/docker.sock\""
