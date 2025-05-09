output "resource_groups" {
  value = {
    for k, value in azurerm_resource_group.resource_groups : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}

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

output "virtual_networks" {
  value = {
    for k, value in azurerm_virtual_network.virtual_networks : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "subnets" {
  value = {
    for k, value in azurerm_subnet.subnets : k => {
      id                   = value.id
      name                 = value.name
      resource_group_name  = value.resource_group_name
      virtual_network_name = value.virtual_network_name
    }
  }
}

output "network_peerings" {
  value = {
    for k, value in azurerm_virtual_network_peering.peerings : k => {
      id                        = value.id
      name                      = value.name
      resource_group_name       = value.resource_group_name
      virtual_network_name      = value.virtual_network_name
      remote_virtual_network_id = value.remote_virtual_network_id
    }
  }
}

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

locals {
  network_security_rules_flattened = flatten([
    for instance_key, instance_value in var.network_security_groups : [
      for rule_key, rule_value in lookup(instance_value, "rules", {}) : {
        key                          = "${instance_key}-${rule_key}"
        name                         = "${rule_key}"
        resource_group_name          = "${instance_value.resource_group.name}"
        network_security_group_name  = "${instance_key}"
      }
    ]
  ])
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

output "network_interfaces" {
  value = {
    for k, value in azurerm_network_interface.network_interfaces : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}
