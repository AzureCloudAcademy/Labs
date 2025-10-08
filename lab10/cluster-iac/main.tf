# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}


#data "azurerm_subscription" "current" {
#}

provider "azurerm" {
  features {
  }
  subscription_id =  "4d0ae3c9-1de5-4be6-b3f0-c39f67aef789" #data.azurerm_subscription.current.subscription_id
}

resource "random_pet" "prefix" {
 
}


resource "azurerm_resource_group" "default" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_log_analytics_workspace" "demo-log-analytics-aks-ws" {
  name                = "${random_pet.prefix.id}-law"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "demo-log-analytics-aks" {
  solution_name         = "Containers"
  workspace_resource_id = azurerm_log_analytics_workspace.demo-log-analytics-aks-ws.id
  workspace_name        = azurerm_log_analytics_workspace.demo-log-analytics-aks-ws.name
  location              = azurerm_resource_group.default.location
  resource_group_name   = azurerm_resource_group.default.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }
}


resource "azurerm_virtual_network" "demo-aks-vnet" {
  name                = "${random_pet.prefix.id}-vnet"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "demo-aks-subnet" {
  name                 = "${random_pet.prefix.id}-subnet"
  resource_group_name  = azurerm_resource_group.default.name
  address_prefixes     = ["192.168.1.0/24"]
  virtual_network_name = azurerm_virtual_network.demo-aks-vnet.name
  service_endpoints    = ["Microsoft.Sql"]
}


resource "azurerm_kubernetes_cluster" "demo-aks" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"
  kubernetes_version  = "1.32.7"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2ps_v6"
    os_disk_size_gb = 30
    vnet_subnet_id  = azurerm_subnet.demo-aks-subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id      = azurerm_log_analytics_workspace.demo-log-analytics-aks-ws.id
    msi_auth_for_monitoring_enabled = true
  }

  role_based_access_control_enabled = true


  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  tags = {
    environment = "Demo"
  }
}


resource "azurerm_container_registry" "demo-aks-container-registry" {
  name                = "AksConainerRegistry"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "Premium"
  admin_enabled       = false
  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}


resource "azurerm_role_assignment" "demo-aks-acr-assignment" {
  principal_id                     = azurerm_kubernetes_cluster.demo-aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.demo-aks-container-registry.id
  skip_service_principal_aad_check = true
}