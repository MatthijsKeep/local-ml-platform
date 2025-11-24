To be honest, I'm not sure how to best install Kubeflow pipelines, it's a bit daunting
https://www.kubeflow.org/docs/components/pipelines/operator-guides/installation/

```bash
export PIPELINE_VERSION=2.14.3

kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
kubectl wait --for condition=established --timeout=60s crd/applications.app.k8s.io
kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/env/dev?ref=$PIPELINE_VERSION" 
```

port forward to see to ui
```bash
kubectl port-forward -n kubeflow svc/ml-pipeline-ui 8080:80
```