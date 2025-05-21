output "public_ips" {
  value = {
    for k, value in azurerm_public_ip.public_ips : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}