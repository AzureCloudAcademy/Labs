# Provisioning a Cluster with IaC (Terraform) – Step-by-Step Guide

This guide walks you through provisioning a minimal cluster (2 nodes) using Infrastructure as Code (IaC) with Terraform.

## Prerequisites

- Terraform installed locally
- Azure CLI authenticated (if using Azure)
- Access to your cloud provider account
- Install kubectl
- Install docker packages and docker-compose (using apt here : https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

## Notes If you are using WSL :
### az-cli install one command Linux WSL
`curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`
### terraform ()
1. Ensure system is up to date and that you have installed gnup and software-properties-common packages. Then use these packages to verify HashiCorp's GPG signature and install HashiCorp's Debian package repository. 

`sudo apt-get update && sudo apt-get install -y gnupg software-properties-common`

2. Install Hashicorp GPG's key

```
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

3. Verify the GPG key fingerprint

```
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```

4. Add Hashicorp Repo to system

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

```

5. Apt update

`sudo apt update`

6. Finally Terraform install

`sudo apt-get install terraform`

### Access to cloud provider account through az cli

az login --use-device

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
<<<<<<< Updated upstream
=======


## Build first docker image for redish-app service built container

(* Ensure to have docker compose installed )
![Link to Documentation for the application](./redishapp.md)

## Then Push to ACR Azure Container Registery
![Link to ACR to AKS Simple deployment](./acr_to_aks.md)


## How to Set PodAntiAffinity
![Pod Anti Affinity for Availability](./pod_anti_affinity.md)

## How to Setup Resource limits
![Setup Resource limits](./resource_limits.md)

## How to Setup a StatefulSet Deployment
![Setup StatefulSet Deployment](./StatefulSet.md)
>>>>>>> Stashed changes
