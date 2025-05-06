resource "local_file" "resource_groups" {
  filename = "azure_export.csv"
  content = templatefile("${path.module}/csv_export.tpl", {
    resource_groups = azurerm_resource_group.azure_resource_groups
    virtual_networks = azurerm_virtual_network.azure_virtual_networks
  })
}