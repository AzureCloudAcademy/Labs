# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
    features {      
    }
    subscription_id = "4d0ae3c9-1de5-4be6-b3f0-c39f67aef789"
}


resource "azurerm_resource_group" "default" {
  name     = "demo-aks-rg"
  location = "West Europe"
}

resource "random_pet" "prefix" {
  
}
resource "azurerm_kubernetes_cluster" "demo-aks" {
    name                = "${random_pet.prefix.id}-aks"
    location            = azurerm_resource_group.default.location 
    resource_group_name = azurerm_resource_group.default.name
    dns_prefix          = "${random_pet.prefix.id}-k8s"
    kubernetes_version  = "1.32.7"

    default_node_pool {
        name            = "default"
        node_count      = 1
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