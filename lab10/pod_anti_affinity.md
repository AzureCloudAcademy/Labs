![pod anti-affinity](./Assets/pod_anti_affinity.png)

## Pod Anti-Affinity 
Pod anti-affinity is a Kubernetes feature that allows you to specify rules for how Pods should not be scheduled on the same node as other Pods. This is useful for ensuring high availability and fault tolerance by preventing Pods from being co-located on the same node, which could lead to a single point of failure.

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

### Create a Manifest file with Pod Anti-Affinity
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

### Add Pod Anti-Affinity Rules

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
  replicas: 3
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
      affinity: 
       podAntiAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
        - labelSelector:
            matchExpressions:
             - key: app
               operator: In
               values:
               - redish-app
          topologyKey: kubernetes.io/hostname
         
      containers:
      - image: $ACR_NAME.azurecr.io/redish-app:latest
        name: redish-app
        ports:
        - containerPort: 80
        resources: {}
status: {}
```

**ℹ️ Note:**  Make sure to replace `$ACR_NAME` with your actual Azure Container Registry name in the `image` field.

### Apply the Manifest File
then apply the manifest file to create the deployment with pod anti-affinity rules:

```bash
kubectl apply -f manifests/redish-app-deployment.yaml
```
### Verify the Deployment
Check the status of the deployment to ensure it has been created successfully:

```bash
kubectl get deployments
```

Check the status of the pods to ensure they are running:

```bash
kubectl get pods
```
### Verify Pod Anti-Affinity
Go to Azure Portal and navigate to your AKS cluster. Check the nodes and pods to verify that the pods are not scheduled on the same node.

![Pod Anti-Affinity in Azure Portal](./Assets/image1.png)

### Cleanup
To clean up the resources created during this lab, you can delete the deployment and any associated resources:

```bash
kubectl delete deployment redish-app
```
### Summary
In this lab, you learned how to implement pod anti-affinity in Kubernetes to ensure that your application pods are not scheduled on the same node. This helps improve the availability and fault tolerance of your application by preventing a single point of failure. You also verified the deployment and pod status in both the command line and Azure Portal.


