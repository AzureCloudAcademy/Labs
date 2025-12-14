output "my_lab_loadbalancer_public_ip" {
  value = azurerm_public_ip.lab_lb_public_ip.ip_address
}