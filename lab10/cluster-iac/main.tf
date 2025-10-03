provider "azurerm" {
    features = {}
}

resource "azurerm_kubernetes_cluster" "example" {
    name                = "${random_pet.prefix.id}-aks"
    location            = var.location ? "" ? azurerm_resource_group.default.location : var.location
    resource_group_name = var.resource_group_name ? azurerm_resource_group.default.name : var.resource_group_name
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