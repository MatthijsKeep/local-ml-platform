.PHONY: up down clean status tunnel

# Setup
up:
	@echo "🚀 Provisioning Infrastructure..."
	./minikube-setup.sh
	@echo "✅ Cluster Ready"

# Tear down
down:
	minikube stop
	colima stop
	@echo "✅ Cluster stopped"

# Nuclear option
clean:
	minikube delete
	colima delete
	@echo "✅ Cluster cleaned"

# Status check
status:
	@echo "📊 Cluster Status:"
	@echo "\n=== Colima ==="
	colima status
	@echo "\n=== Minikube ==="
	minikube status
	@echo "\n=== Kubernetes ==="
	kubectl cluster-info
	kubectl get nodes

# Access services (replaces Kind's port mapping)
tunnel:
	@echo "🌐 Starting Minikube tunnel..."
	@echo "   This exposes LoadBalancer services on localhost"
	@echo "   Keep this terminal open"
	export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
	minikube tunnel
