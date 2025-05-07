resource "local_file" "resources_export" {
  filename = "azure_export.csv"
  content = templatefile("${path.module}/csv_export.tpl", {
    resource_groups = azurerm_resource_group.resource_groups
    virtual_networks = azurerm_virtual_network.virtual_networks
  })
}