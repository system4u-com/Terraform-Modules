resource "azurerm_network_security_group" "network_security_groups" {
  for_each = var.network_security_groups

  name                = each.key
  location            = each.value.resource_group.location
  resource_group_name = each.value.resource_group.name
  tags                = each.value.tags
}

locals {
  flattened_nsg_rules = flatten([
    for instance_key, instance_value in var.network_security_groups : [
      for rule_key, rule_value in lookup(instance_value, "rules", {}) : {
        key                          = "${instance_key}-${rule_key}"
        name                         = "${rule_key}"
        priority                     = rule_value.priority
        direction                    = rule_value.direction
        access                       = rule_value.access
        protocol                     = rule_value.protocol
        source_address_prefix        = rule_value.source_address_prefix
        source_address_prefixes      = rule_value.source_address_prefixes
        destination_address_prefix   = rule_value.destination_address_prefix
        destination_address_prefixes = rule_value.destination_address_prefixes
        source_port_range            = rule_value.source_port_range
        source_port_ranges           = rule_value.source_port_ranges
        destination_port_range       = rule_value.destination_port_range
        destination_port_ranges      = rule_value.destination_port_ranges
        description                  = rule_value.description
        resource_group_name          = "${instance_value.resource_group.name}"
        network_security_group_name  = "${instance_key}"
      }
    ]
  ])
}

resource "azurerm_network_security_rule" "network_security_rules" {
  for_each = { for rule in local.flattened_nsg_rules : rule.key => rule }

  name                         = each.key
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_address_prefix        = each.value.source_address_prefix
  source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefix   = each.value.destination_address_prefix
  destination_address_prefixes = each.value.destination_address_prefixes
  source_port_range            = each.value.source_port_range
  source_port_ranges           = each.value.source_port_ranges
  destination_port_range       = each.value.destination_port_range
  destination_port_ranges      = each.value.destination_port_ranges
  description                  = each.value.description
  resource_group_name          = each.value.resource_group_name
  network_security_group_name  = each.value.network_security_group_name
}

resource "azurerm_subnet_network_security_group_association" "network_security_group_subnet_associations" {
  for_each = { for k, v in var.network_security_groups : k => v if v.subnet_association != null }

  subnet_id                 = each.value.subnet_association.id
  network_security_group_id = azurerm_network_security_group.network_security_groups[each.key].id
}

resource "azurerm_network_interface_security_group_association" "network_security_group_nic_associations" {
  for_each = { for k, v in var.network_security_groups : k => v if v.nic_association != null }

  network_interface_id      = each.value.nic_association.id
  network_security_group_id = azurerm_network_security_group.network_security_groups[each.key].id
}
