resource "azurerm_network_security_group" "network_security_groups" {
  for_each = var.network_security_groups

  name                = each.key
  location            = each.value.resource_group.location
  resource_group_name = each.value.resource_group.name
  tags                = each.value.tags

  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                         = security_rule.key
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
      access                       = security_rule.value.access
      protocol                     = security_rule.value.protocol
      source_address_prefix        = security_rule.value.source_address_prefix
      source_address_prefixes      = security_rule.value.source_address_prefixes
      destination_address_prefix   = security_rule.value.destination_address_prefix
      destination_address_prefixes = security_rule.value.destination_address_prefixes
      source_port_range            = security_rule.value.source_port_range
      source_port_ranges           = security_rule.value.source_port_ranges
      destination_port_range       = security_rule.value.destination_port_range
      destination_port_ranges      = security_rule.value.destination_port_ranges
      description                  = security_rule.value.description
    }
  }
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