resource "azurerm_linux_function_app" "linux_function_apps" {
    for_each = var.linux_function_apps
    
    name                = coalesce(each.value.name, each.key)
    resource_group_name = each.value.resource_group.name
    location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
    storage_account_name    = each.value.storage_account != null ? each.value.storage_account.name : null
    storage_account_access_key = each.value.storage_account_access_key
    service_plan_id     = each.value.service_plan.id
    https_only          = each.value.https_only
    
    app_settings = each.value.app_settings

    tags = each.value.tags
       
    site_config {

        application_stack {
            node_version = each.value.site_config.application_stack.node_version
            python_version = each.value.site_config.application_stack.python_version
            java_version = each.value.site_config.application_stack.java_version
            dotnet_version = each.value.site_config.application_stack.dotnet_version
            powershell_core_version = each.value.site_config.application_stack.powershell_core_version
            
        }
        application_insights_connection_string = each.value.site_config.application_insights_connection_string
    }
    
    dynamic "identity" {
        for_each = each.value.identity != null ? [each.value.identity] : []
        content {
            type         = identity.value.type
            identity_ids = identity.value.identity_ids
        }
    }
}