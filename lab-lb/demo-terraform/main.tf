terraform {
  required_version = ">=1.5.0"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=4.0.0"
    }
  }
}

provider "azurerm" {
subscription_id = var.subscription_id
resource_provider_registrations = "none"
  features {
    
  }
}

# Resource Group creation
resource "azurerm_resource_group" "load_balancer_rg" {
  name = "lab-lb-rg"
  location = var.location
}


# Networking

resource "azurerm_virtual_network" "lab_vnet" {
  name                = "lab-lb-vnet"
  location = var.location
  resource_group_name = azurerm_resource_group.load_balancer_rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]  
}

resource "azurerm_subnet" "lab_subnet" {
  name                 = "lab-lb-subnet"
  resource_group_name  = azurerm_resource_group.load_balancer_rg.name
  virtual_network_name = azurerm_virtual_network.lab_vnet.name
  address_prefixes     = ["10.0.1.0/24"]  
}

# Network Security Group need to allow traffic to VMs later on : allow HTTP (port 80) from Internet to VMs and through Load Balancer
resource "azurerm_network_security_group" "lab_nsg" {
  name                = "lab-lb-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.load_balancer_rg.name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "Environment" = "Development"
  }
}

# Associate NSG to subnet
resource "azurerm_subnet_network_security_group_association" "lab_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.lab_subnet.id
  network_security_group_id = azurerm_network_security_group.lab_nsg.id  
}

# To assign a public IP to the LB we need create public IP resource
resource "azurerm_public_ip" "lab_lb_public_ip" { 
    name = "lab-lb-public-ip"
    location= var.location
    resource_group_name = azurerm_resource_group.load_balancer_rg.name 
    allocation_method = "Static"
    sku = "Standard"
}

# Create the load balancer
resource "azurerm_lb" "lab_load_balancer" {
    name = "lab-lb"
    location = var.location
    resource_group_name = azurerm_resource_group.load_balancer_rg.name
    frontend_ip_configuration {
        name = "lab-lb-frontend-config"
        public_ip_address_id = azurerm_public_ip.lab_lb_public_ip.id
    }
}
resource "azurerm_lb_backend_address_pool" "bepool" {
  name            = "be-pool"
  loadbalancer_id = azurerm_lb.lab_load_balancer.id
}

resource "azurerm_lb_probe" "http_probe" {
  name            = "http-80"
  loadbalancer_id = azurerm_lb.lab_load_balancer.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http_rule" {
  name                           = "http-80-rule"
  loadbalancer_id                = azurerm_lb.lab_load_balancer.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "lab-lb-frontend-config"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}

# -------- Cloud-init (install nginx + show hostname) --------
# locals {
#   cloud_init = <<-EOT
#     #cloud-config
#     package_update: true
#     packages:
#       - nginx
#     runcmd:
#       - bash -c 'echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.nginx-debian.html'
#       - systemctl enable nginx
#       - systemctl restart nginx
#   EOT
# }

# -------- NICs + VMs (2 instances) --------
resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "nic-${count.index + 1}"
  location            = var.location
  resource_group_name = azurerm_resource_group.load_balancer_rg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.lab_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_to_bepool" {
  count                   = 2
  network_interface_id    = azurerm_network_interface.nic[count.index].id
  ip_configuration_name   = "ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = 2
  name                = "vm-${count.index + 1}"
  location            = var.location
  resource_group_name = azurerm_resource_group.load_balancer_rg.name
  size                = "Standard_F2"

  admin_username                  = var.admin_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("./public_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb       = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode("init.sh")
}
