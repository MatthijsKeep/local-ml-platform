# Makefile

# "PHONY" means these are commands, not files
.PHONY: up down clean

# The "One-Click" Setup
up:
	@echo "🚀 Provisioning Infrastructure..."
	./podman-setup.sh
	@echo "📦 Creating Kubernetes Cluster..."
	# We use the Podman provider explicitly
	KIND_EXPERIMENTAL_PROVIDER=podman kind create cluster --config kind-config.yaml
	@echo "✅ Metal Layer Complete. Ready for Core Services."

# Tear everything down
down:
	kind delete cluster
	podman machine stop

# The "Nuke it" option - useful when things break (and they will)
clean: down
	podman machine rm -f
