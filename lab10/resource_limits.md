![Resource Limits](./Assets/YAML_resource_limits.png)

## Resource Limits in Kubernetes
Resource limits in Kubernetes are used to control the amount of CPU and memory resources that a container can use. This is important for ensuring that no single container can monopolize the resources of a node, which could lead to performance issues or even crashes of other containers running on the same node.

### Setting Resource Limits
To set resource limits for a container, you can specify the `resources` field in the container's manifest file. The `resources` field can include both `requests` and `limits`. The `requests` field specifies the minimum amount of resources that the container needs to run, while the `limits` field specifies the maximum amount of resources that the container can use.

### Delete Existing Deployment
first of all delete the deployments that have already been created:
```bash
kubectl delete deployment redish-app
```

check that the deployment has been deleted:
```bash
kubectl get deployments
```

```bash
kubectl get pods
```

### Create a Manifest file with Resource Limits
Run the following command to create a templated manifest file with ACR integration

```bash
kubectl create deployment redish-app \
--image=$ACR_NAME.azurecr.io/redish-app:latest \
--port=80 \
--dry-run=client \
--output yaml > manifests/redish-app-deployment.yaml
```

!Note: Make sure to replace `$ACR_NAME` with your actual Azure Container Registry name.

!Note: Make sure you have the `manifests` directory created in your current working directory before running the command. If it doesn't exist, you can create it using the following command:
```bash
mkdir manifests
```

### Add Resource Limits
Replace the content of `manifests/redish-app-deployment.yaml` with the following:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: redish-app
  name: redish-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: redish-app
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: redish-app
    spec:
      containers:
      - image: $ACR_NAME.azurecr.io/redish-app:latest
        name: redish-app
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: "250m"
            memory: "256Mi"
          limits:
            cpu: "500m"
            memory: "512Mi"
status: {}
```

In the yaml definition above, we have set the following resource limits:
- **Requests**: 
  - CPU: `250m` (0.25 of a CPU core)
  - Memory: `256Mi` (256 MiB of memory)
- **Limits**:
    - CPU: `500m` (0.5 of a CPU core)
    - Memory: `512Mi` (512 MiB of memory)
    
### Apply the Manifest file
Run the following command to apply the manifest file and create the Deployment resource with the specified resource limits:

```bash
kubectl apply -f manifests/redish-app-deployment.yaml
```
### Verify the Deployment
You can verify that the Deployment has been created and the resource limits are applied by running the following
command:

```bash
kubectl get deployments redish-app -o yaml
```

### Check the Pods
To check the status of the Pods created by the Deployment, you can run the following command:

```bash
kubectl get pods -l app=redish-app
```
This will list all the Pods with the label `app=redish-app`, and you should see that they are running with the specified resource limits.

