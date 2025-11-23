# Setting up Minio using Helm

## Add minio helm repository
```bash
❯ helm repo add minio https://charts.min.io/                                                        
"minio" has been added to your repositories
```
and then 
```bash
❯ helm repo update                          
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "minio" chart repository
...Successfully got an update from the "community-charts" chart repository
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
```
note: I'm not sure where this "ends up" if you run it? Like where is it stored that we ran this. I don't see any new files.
## Install the Helm chart using our config
```bash
❯ helm upgrade --install minio minio/minio \  
  --namespace minio-system \
  --create-namespace \
  --values 1-core-services/minio/values.yaml
  Release "minio" does not exist. Installing it now.

NAME: minio
LAST DEPLOYED: Sun Nov 23 12:53:23 2025
NAMESPACE: minio-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
MinIO can be accessed via port 9000 on the following DNS name from within your cluster:
minio.minio-system.cluster.local
```
There will be more descriptions, namely how you can access it from localhost.

**But**, since we set up NGINX, we should be able to access it from `localhost:8080/minio/`. 
After setting up ingress with

```bash
❯ kubectl apply -f 1-core-services/minio/ingress.yaml      

ingress.networking.k8s.io/minio-ingress configured
```