![Deploying AI App from ACR to AKS](./Assets/ACR_to_AKS.png)

## Deploy an AI App from ACR to AKS (Azure Container Registry to Azure Kubernetes Service)

### Using kubectl to create resource manifests

Going back to the azure-openai-chat application, we can create a Deployment resource to run the application in Kubernetes.

If you have never written a Kubernetes manifest file, you can use the Draft CLI to create a manifest file for you or use another common method which is to use the kubectl CLI to create a manifest file.

First lets set the environment variable for the Azure Container Registry (ACR) name.
```bash
export ACR_NAME="your-acr-name"
```

### Delete Existing Deployment
first of all delete the deployments that have already been created:
```bash
kubectl delete deployment redish-app
```

## Step by step

Create a directory called manifests in the root of the repository to store the manifest files.
```bash
mkdir manifests
```


Let's create a Deployment resource manifest for the azure openai chat application.
```bash
kubectl create deployment redish-app \
--image=$ACR_NAME.azurecr.io/redish-app:latest \
--port=80 \
--dry-run=client \
--output yaml > manifests/redish-app-deployment.yaml
```

This command creates a Deployment resource named `redish-app` using the image from the Azure Container Registry (ACR) and outputs the manifest in YAML format to a file named `redish-app-deployment.yaml` in the `manifests` directory.

### Creating resources with kubectl

Deploying a manifest file is as simple as running the following command.
```bash
kubectl apply -f manifests/redish-app-deployment.yaml
```

To view the status of the Deployment resource, you can run the following command.
```bash
kubectl get deployments redish-app
```

Once you see that the contoso-air Pod is running, you can stop the watch command by pressing Ctrl+C in the terminal.

To view the application in your browser, you can run a port-forward command to forward the port from the Pod to your local machine.
```bash
kubectl port-forward deployment/redish-app 8080:80
```

> **ℹ️ Note:**  
> By default, Kubernetes resources are only accessible from within the cluster. To access a resource from outside the cluster, you need to create a Service resource to expose it. We'll cover that later.  
>  
> In the meantime, you can use the `kubectl port-forward` command to forward a port from your local machine to the Pod. This allows you to access the application as if it were running locally.

You can now access the application in your browser at http://localhost:8080/.

To stop the port-forward command, you can press Ctrl+C in the terminal.
