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
	minikube tunnel

# Alternative: Port forward to match Kind's localhost:8080
tunnel-8080:
	@echo "🔌 Port forwarding to localhost:8080..."
	kubectl port-forward -n ingress-nginx \
	  service/ingress-nginx-controller \
	  8080:80 8443:443
