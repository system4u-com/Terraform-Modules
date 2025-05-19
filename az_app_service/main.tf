resource "azurerm_service_plan" "service_plans" {
    for_each = var.service_plans

    name                = coalesce(each.value.name, each.key)
    resource_group_name = each.value.resource_group.name
    location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
    sku_name = each.value.sku_name
    os_type = each.value.os_type
    
    tags = each.value.tags
}

resource "azurerm_linux_function_app" "linux_function_apps" {
    for_each = var.linux_function_apps
    
    name                = coalesce(each.value.name, each.key)
    resource_group_name = each.value.resource_group.name
    location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
    storage_account_name    = each.value.storage_account.name
    storage_account_access_key = each.value.storage_account_access_key
    service_plan_id     = each.value.service_plan.id
    https_only          = each.value.https_only
    
    app_settings = each.value.app_settings

    tags = each.value.tags
    
    site_config {
        application_stack {
        node_version = coalesce(each.value.site_config.application_stack.node_version, null)
        }
    
        application_insights_connection_string = each.value.site_config.application_insights_connection_string
    }
    
    identity {
        type         = each.value.identity.type
        identity_ids = each.value.identity.identity_ids
    }
    
    lifecycle {
        ignore_changes = []
    }
  
}