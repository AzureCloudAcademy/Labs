# AKS Cluster Provisioning with Terraform

This guide provides step-by-step instructions to provision an Azure Kubernetes Service (AKS) cluster using Terraform. The entry point for this setup is the `main.tf` file.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://www.terraform.io/downloads.html)
- Azure subscription with sufficient permissions

## Steps

### 1. Clone the Repository

```bash
git clone <repository-url>
cd cluster-iac
```

(!) Note : How to generate Public CERT through OpenSSL command line and store cert and key in testdata folder

`openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout testdata/key.pem -out testdata/cert.pem -subj "/DC=org/DC=OpenSSL/DC=users/CN=Olfa A" -passin pass:olfapass`

### 2. Authenticate with Azure

```bash
az login --use-device
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review and Configure Variables

Edit `main.tf` and any variable files (e.g., `variables.tf`) to set your desired configuration (resource group, location, node count, etc.).

### 5. Preview the Execution Plan

```bash
terraform plan
```

Review the output to verify resources to be created.

### 6. Apply the Terraform Configuration

```bash
terraform apply
```

Confirm the action when prompted. Terraform will provision the AKS cluster and related resources.

### 7. Access AKS Cluster Credentials

After successful deployment, retrieve cluster credentials:

```bash
az aks get-credentials --resource-group <resource-group> --name <aks-cluster-name>
```

### 8. Verify Cluster Access

```bash
kubectl get nodes
```

You should see the nodes in your AKS cluster.

## Cleanup

To remove all resources created by Terraform:

```bash
terraform destroy
```

## References

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AKS Documentation](https://docs.microsoft.com/en-us/azure/aks/)

---

**Note:** Always review and customize the Terraform files to fit your environment and security requirements.