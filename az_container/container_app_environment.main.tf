resource "azurerm_container_app_environment" "container_app_environments" {
    for_each = var.container_app_environments
    
    name                = coalesce(each.value.name, each.key)
    location            = coalesce(each.value.location, each.value.resource_group.location)
    resource_group_name = each.value.resource_group.name
    tags                = each.value.tags
    
    logs_destination = each.value.logs_destination
    log_analytics_workspace_id = each.value.log_analytics_workspace_id
}