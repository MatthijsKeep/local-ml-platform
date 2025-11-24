# Makefile for Declarative KFP (Enterprise Pattern)

# The only variable we need is the location of our Kustomization
KUSTOMIZE_PATH := .

.PHONY: help deploy clean status logs

help:
	@echo "🚀 Declarative KFP Manager"
	@echo "Targets:"
	@echo "  deploy   - Apply the full KFP stack (Upstream + ARM64 Patches + Ingress)"
	@echo "  status   - Check health of the stack"
	@echo "  clean    - Delete everything defined in kustomization.yaml"
	@echo "  logs     - Tail logs for the main API server"

# This is the declarative command. It applies the FINAL state defined in kustomization.yaml
deploy:
	@echo "🔄 Reconciling KFP State..."
	kubectl apply -k $(KUSTOMIZE_PATH)
	@echo "⏳ Waiting for MinIO (Storage Layer)..."
	kubectl wait --namespace kubeflow --for=condition=ready pod -l app=minio --timeout=120s
	@echo "⏳ Waiting for API Server (Application Layer)..."
	kubectl wait --namespace kubeflow --for=condition=ready pod -l app=ml-pipeline --timeout=300s
	@echo "✅ Deployment Complete. Access UI at http://localhost/pipeline"

status:
	kubectl get pods -n kubeflow

clean:
	kubectl delete -k $(KUSTOMIZE_PATH)

logs:
	kubectl logs -n kubeflow -l app=ml-pipeline -f
