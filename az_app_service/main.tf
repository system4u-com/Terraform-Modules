resource "azurerm_service_plan" "service_plans" {
    for_each = var.service_plans

    name                = coalesce(each.value.name, each.key)
    resource_group_name = each.value.resource_group.name
    location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
    sku_name = each.value.sku_name
    os_type = each.value.os_type
    
    tags = each.value.tags
}
