resource "azurerm_automation_runbook" "automation_runbooks" {
  for_each = var.automation_runbooks

  name                    = coalesce(each.value.name, each.key)
  location                = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name     = each.value.resource_group.name
  automation_account_name = each.value.automation_account_name
  log_verbose             = each.value.log_verbose
  log_progress            = each.value.log_progress
  description             = each.value.description
  runbook_type            = each.value.runbook_type
  content = each.value.content
  dynamic "publish_content_link" {
    for_each = try(each.value.publish_content_link, {})
    content {
      uri          = each.value.uri
      version      = each.value.version
      hash {
        algorithm = each.value.content_hash.algorithm
        value     = each.value.content_hash.value
      }
    }
  }
  tags                    = each.value.tags
}
