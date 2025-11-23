- Download NGINX manifest optimized for kind and put it in the correct place
```bash
curl -o 1-core-services/ingress-nginx/ingress-nginx.yaml https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

Note: This is different from the "normal" NGINX manifest, because of the differences in networking between a cloud load balancer and a local system. Thus, for a cloud system it would be different, but I'm not sure how yet.

- After downloading, apply the manifest
```bash
kubectl apply -f 1-core-services/ingress-nginx/ingress-nginx.yaml
```


- Check if it is running
```bash
kubectl get pods -n ingress-nginx
```
You should see something like this:
```bash
❯ kubectl get pods -n ingress-nginx
NAME                                        READY   STATUS    RESTARTS   AGE
ingress-nginx-controller-76f7f87994-86f2n   1/1     Running   0          30s
```

And if you want you can even test it by running:
```bash
curl localhost:8080
```
If you get `404 Not Found` from nginx, it is listening (just not doing anything yet)
If you get a connection refused, the port mapping probably failed