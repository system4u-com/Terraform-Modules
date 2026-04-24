resource "azurerm_windows_function_app" "windows_function_apps" {
  for_each = var.windows_function_apps

  name                          = coalesce(each.value.name, each.key)
  resource_group_name           = each.value.resource_group.name
  location                      = coalesce(each.value.location, each.value.resource_group.location)
  storage_account_name          = each.value.storage_account != null ? each.value.storage_account.name : null
  storage_account_access_key    = each.value.storage_account_access_key
  storage_uses_managed_identity = each.value.storage_uses_managed_identity
  service_plan_id               = each.value.service_plan.id
  functions_extension_version   = each.value.functions_extension_version
  https_only                    = each.value.https_only

  app_settings = each.value.app_settings

  site_config {
    dynamic "application_stack" {
      for_each = try(each.value.site_config.application_stack, null) != null ? [each.value.site_config.application_stack] : []
      content {
        powershell_core_version = try(application_stack.value.powershell_core_version, null)
      }
    }

    application_insights_connection_string = try(each.value.site_config.application_insights_connection_string, null)
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = each.value.tags
}
