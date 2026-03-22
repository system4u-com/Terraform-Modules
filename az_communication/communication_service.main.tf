resource "azurerm_communication_service" "communication_services" {
    for_each = var.communication_services

    name                = coalesce(each.value.name, each.key)
    resource_group_name = each.value.resource_group.name
    data_location = each.value.data_location
    tags = each.value.tags
}