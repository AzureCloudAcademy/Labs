# Provisioning a Cluster with IaC (Terraform) – Step-by-Step Guide

This guide walks you through provisioning a minimal cluster (2 nodes) using Infrastructure as Code (IaC) with Terraform.

## Prerequisites

- Terraform installed locally
- Azure CLI authenticated (if using Azure)
- Access to your cloud provider account

## Steps

### 1. Prepare Your Terraform Configuration

Create a new folder (e.g., `cluster-iac/`) and add your Terraform files. Example structure:
```
cluster-iac/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

### 2. Define Provider and Resources

In `main.tf`, specify your cloud provider and cluster resource. Example for Azure Kubernetes Service (AKS):

```hcl
provider "azurerm" {
    features = {}
}

resource "azurerm_kubernetes_cluster" "example" {
    name                = "${random_pet.prefix.id}-aks"
    location            = azurerm_resource_group.default.location
    resource_group_name = azurerm_resource_group.default.name
    dns_prefix          = "${random_pet.prefix.id}-k8s"
    kubernetes_version  = "1.32.7"

    default_node_pool {
        name            = "default"
        node_count      = 2
        vm_size         = "Standard_D2_v2"
        os_disk_size_gb = 30
    }

    identity {
        type = "SystemAssigned"
    }
    
    role_based_access_control_enabled = true

    tags = {
        environment = "Demo"
    }
}
```

Instead of Managed assigned_identity for identity management, we can also set, to make service_principal to authenticate to Azure provider and this by adding it beforehand on  ActiveDirectory, appId and password are to be added in variables.

```
 service_principal {
        client_id     = var.appId
        client_secret = var.password
    }
```

### 3. Configure Variables

In `variables.tf`, define any required variables (e.g., resource group name, location).

```hcl
variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
    default = "East US"
}
```

### 4. Initialize Terraform

Open your terminal in the `cluster-iac/` folder and run:
```sh
terraform init
```

### 5. Review and Apply the Plan

Preview the changes:
```sh
terraform plan
```
Apply the configuration to provision the cluster:
```sh
terraform apply
```
Confirm when prompted.

### 6. Verify Cluster Creation

Once complete, use your cloud provider's portal or CLI to verify the cluster is running with 2 nodes.

---

### 7. Getting Started with AKS (Azure Kubernetes Service)

## Connect to Your Kubernetes Cluster

To connect to your Kubernetes cluster, run:

```sh
az aks get-credentials --resource-group $RG_NAME --name $AKS_NAME
```

To view your kubeconfig file, use:

```sh
kubectl config view --raw
```

## Explore Kubernetes Resources

To see details about the `Deployment` resource, run:

```sh
kubectl explain deployment
```

For a complete list of available attributes, use the `--recursive` flag:

```sh
kubectl explain deployment --recursive
```

This outputs a large set of attributes. To focus on a specific part of the resource, such as configuring containers in the Pod template, run:

```sh
kubectl explain deployment.spec.template.spec.containers
```

This command displays the fields available for containers within the Deployment resource, helping you understand how to configure them properly.

**Note:**  
- Adjust resource names and parameters to fit your environment.
- Do not hardcode credentials or secrets in your Terraform files.
