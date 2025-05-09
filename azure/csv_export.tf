resource "local_file" "resources_export" {
  filename = "azure_export.csv"
  content = templatefile("${path.module}/csv_export.tpl", {
    resource_groups         = azurerm_resource_group.resource_groups
    virtual_networks        = azurerm_virtual_network.virtual_networks
    subnets                 = azurerm_subnet.subnets
    peerings                = azurerm_virtual_network_peering.peerings
    public_ips              = azurerm_public_ip.public_ips
    network_security_groups = azurerm_network_security_group.network_security_groups
    network_security_rules  = local.network_security_rules_flattened
    network_interfaces      = azurerm_network_interface.network_interfaces
  })
}
