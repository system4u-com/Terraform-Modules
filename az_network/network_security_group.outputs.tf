output "network_security_groups" {
  value = {
    for k, value in azurerm_network_security_group.network_security_groups : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "network_security_rules" {
  value = {
    for k, value in local.network_security_rules_flattened : k => {
      name                        = value.name
      network_security_group_name = value.network_security_group_name
      resource_group_name         = value.resource_group_name
    }
  }
}

