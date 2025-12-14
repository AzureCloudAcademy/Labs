
variable "subscription_id" {
  type = string
  default = "1b9fd53e-e444-4bf1-aa12-303d55b6c9b2"
}
variable "location" {
  type = string
  default = "westeurope"
}

variable "admin_username" {
  type = string
  default = "azureuser-admin"
}

variable "ssh_public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyvV6YkX8Z6T0u8K2V9H3f7h0mO6Y5X5H9"
}