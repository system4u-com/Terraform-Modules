resource "azurerm_email_communication_service" "email_communication_services" {
    for_each = var.email_communication_services

    name                = coalesce(each.value.name, each.key)
    resource_group_name = each.value.resource_group.name
    data_location = each.value.data_location
    tags = each.value.tags
}