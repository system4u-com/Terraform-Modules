resource "azurerm_resource_group" "azure_resource_groups" {
    for_each = var.azure_resource_groups

    name = each.key
    location = each.value.location == "" ? var.azure_default_location : each.value.location
    tags = each.value.tags
}