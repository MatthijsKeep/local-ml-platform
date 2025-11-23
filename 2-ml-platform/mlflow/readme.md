# setting up mlflow
## postgres
setting up postgres (one of the remaining bitnami charts?)
```bash
❯ helm upgrade --install mlflow-postgres bitnami/postgresql \
  --namespace ml-platform \
  --create-namespace \
  --values 2-ml-platform/mlflow/postgres.yaml
Release "mlflow-postgres" does not exist. Installing it now.
I1123 14:13:03.903003   82289 warnings.go:110] "Warning: spec.SessionAffinity is ignored for headless services"
NAME: mlflow-postgres
LAST DEPLOYED: Sun Nov 23 14:13:03 2025
NAMESPACE: ml-platform
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: postgresql
CHART VERSION: 18.1.11
APP VERSION: 18.1.0
```

check that it is up and running with:
```bash
❯ kubectl wait --namespace ml-platform \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=postgresql \
  --timeout=120s

pod/mlflow-postgres-postgresql-0 condition met
```

## mlflow

```bash
❯ helm upgrade --install mlflow community-charts/mlflow \
  --namespace ml-platform \
  --values 2-ml-platform/mlflow/values.yaml
Release "mlflow" has been upgraded. Happy Helming!
NAME: mlflow
LAST DEPLOYED: Sun Nov 23 14:20:33 2025
NAMESPACE: ml-platform
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace ml-platform -l "app.kubernetes.io/name=mlflow,app.kubernetes.io/instance=mlflow" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace ml-platform $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace ml-platform port-forward $POD_NAME 8080:$CONTAINER_PORT
```

then apply the ingress using:

```bash
❯ kubectl apply -f 2-ml-platform/mlflow/ingress-mlflow.yaml

ingress.networking.k8s.io/mlflow-ingress created
```
