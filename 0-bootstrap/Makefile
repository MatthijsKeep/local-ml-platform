# Makefile

# "PHONY" means these are commands, not files
.PHONY: up down clean

# Setup
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
	@echo "✅ Cluster succesfully deleted and stopped."

# The "Nuke it" option (useful when things break)
clean: down
	podman machine rm -f
	@echo "✅ Cluster cleaned."
