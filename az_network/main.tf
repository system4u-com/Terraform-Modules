resource "azurerm_virtual_network" "virtual_networks" {
  for_each = var.virtual_networks

  name                = each.key
  resource_group_name = each.value.resource_group.name
  location            = each.value.resource_group.location
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = each.value.tags
}

resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = coalesce(each.value.name, each.key) // Use the key as the name if name not specified
  resource_group_name  = each.value.virtual_network.resource_group_name
  virtual_network_name = each.value.virtual_network.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_interface" "network_interfaces" {
  for_each = var.network_interfaces

  name                = each.key
  location            = each.value.resource_group.location
  resource_group_name = each.value.resource_group.name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name                          = ip_configuration.key
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address            = ip_configuration.value.private_ip_address
      private_ip_address_version    = ip_configuration.value.private_ip_address_version
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
    }
  }
  
  tags = each.value.tags
  
}

resource "azurerm_public_ip" "public_ips" {
  for_each = var.public_ips

  name                = each.key
  resource_group_name = each.value.resource_group.name
  location            = each.value.resource_group.location
  sku                 = each.value.sku
  allocation_method   = each.value.allocation_method
  domain_name_label   = each.value.domain_name_label
  tags                = each.value.tags
}

resource "azurerm_virtual_network_peering" "peerings" {
  for_each = var.peerings

  name                         = each.key
  resource_group_name          = each.value.resource_group.name
  virtual_network_name         = each.value.virtual_network.name
  remote_virtual_network_id    = each.value.remote_virtual_network.id
  allow_virtual_network_access = each.value.allow_virtual_network_access
}

resource "azurerm_route_table" "network_route_tables" {
  for_each = var.network_route_tables

  name                = each.key
  location            = each.value.resource_group.location
  resource_group_name = each.value.resource_group.name
  tags                = each.value.tags

  dynamic "route" {
    for_each = each.value.routes
    content {
      name = route.key
      address_prefix = route.value.address_prefix
      next_hop_type = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}

resource "azurerm_subnet_route_table_association" "network_route_table_subnet_associations" {
  for_each = { for k, v in var.network_route_tables : k => v if v.subnet_association != null }

  subnet_id                 = each.value.subnet_association.id
  route_table_id = azurerm_route_table.network_route_tables[each.key].id
}

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
