resource "local_file" "resource_groups" {
  filename = "azure_resource_groups.csv"
  content = templatefile("${path.module}/resource_groups.tpl", {
    resources = azurerm_resource_group.azure_resource_groups
  })
}