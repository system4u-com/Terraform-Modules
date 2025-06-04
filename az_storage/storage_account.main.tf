resource "azurerm_storage_account" "storage_accounts" {
  for_each = var.storage_accounts

  name                       = coalesce(each.value.name, each.key)
  resource_group_name        = each.value.resource_group.name
  location                   = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  account_tier               = each.value.account_tier
  account_kind               = each.value.account_kind
  account_replication_type   = each.value.account_replication_type
  access_tier                = each.value.access_tier
  https_traffic_only_enabled = each.value.https_traffic_only_enabled


  tags = each.value.tags

  dynamic "network_rules" {
    for_each = each.value.network_rules != null ? [each.value.network_rules] : []

    content {
      bypass                     = network_rules.value.bypass
      default_action             = network_rules.value.default_action
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnets != null ? [for subnet in network_rules.value.virtual_network_subnets : subnet.id] : [] // Convert the list of objects to a list of strings
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_accounts_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
    { for k, v in var.storage_accounts : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) } :
    { for k, v in var.storage_accounts : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) }
  ) : {}

  name                       = "${each.key}-diagnostic-setting"
  target_resource_id         = azurerm_storage_account.storage_accounts[each.key].id
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  metric {
    category = coalesce(each.value.monitoring.metrics, "Transaction")
    enabled  = each.value.monitoring.metrics_enabled
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_accounts_blobs_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
    { for k, v in var.storage_accounts : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) && v.monitoring.blob.enabled } :
    { for k, v in var.storage_accounts : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) && v.monitoring.blob.enabled }
  ) : {}

  name                       = "${each.key}-blob-diagnostic-setting"
  target_resource_id         = "${azurerm_storage_account.storage_accounts[each.key].id}/blobServices/default/"
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  enabled_log {
    category = each.value.monitoring.blob.log_category
    category_group = (
      each.value.monitoring.blob.log_category == null || each.value.monitoring.blob.log_category == "" ?
      coalesce(each.value.monitoring.blob.log_category_group, "audit") :
      null
    )
  }
  metric {
    category = coalesce(each.value.monitoring.blob.metrics, "Transaction")
    enabled  = each.value.monitoring.blob.metrics_enabled
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_accounts_queues_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
    { for k, v in var.storage_accounts : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) && v.monitoring.queue.enabled } :
    { for k, v in var.storage_accounts : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) && v.monitoring.queue.enabled }
  ) : {}

  name                       = "${each.key}-queue-diagnostic-setting"
  target_resource_id         = "${azurerm_storage_account.storage_accounts[each.key].id}/queueServices/default/"
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  enabled_log {
    category = each.value.monitoring.queue.log_category
    category_group = (
      each.value.monitoring.queue.log_category == null || each.value.monitoring.queue.log_category == "" ?
      coalesce(each.value.monitoring.queue.log_category_group, "audit") :
      null
    )
  }
  metric {
    category = coalesce(each.value.monitoring.queue.metrics, "Transaction")
    enabled  = each.value.monitoring.queue.metrics_enabled
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_accounts_tables_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
    { for k, v in var.storage_accounts : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) && v.monitoring.table.enabled } :
    { for k, v in var.storage_accounts : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) && v.monitoring.table.enabled }
  ) : {}

  name                       = "${each.key}-table-diagnostic-setting"
  target_resource_id         = "${azurerm_storage_account.storage_accounts[each.key].id}/tableServices/default/"
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  enabled_log {
    category = each.value.monitoring.table.log_category
    category_group = (
      each.value.monitoring.table.log_category == null || each.value.monitoring.table.log_category == "" ?
      coalesce(each.value.monitoring.table.log_category_group, "audit") :
      null
    )
  }
  metric {
    category = coalesce(each.value.monitoring.table.metrics, "Transaction")
    enabled  = each.value.monitoring.table.metrics_enabled
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_accounts_files_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
    { for k, v in var.storage_accounts : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) && v.monitoring.file.enabled } :
    { for k, v in var.storage_accounts : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) && v.monitoring.file.enabled }
  ) : {}

  name                       = "${each.key}-file-diagnostic-setting"
  target_resource_id         = "${azurerm_storage_account.storage_accounts[each.key].id}/fileServices/default/"
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  enabled_log {
    category = each.value.monitoring.file.log_category
    category_group = (
      each.value.monitoring.file.log_category == null || each.value.monitoring.file.log_category == "" ?
      coalesce(each.value.monitoring.file.log_category_group, "audit") :
      null
    )
  }
  metric {
    category = coalesce(each.value.monitoring.file.metrics, "Transaction")
    enabled  = each.value.monitoring.file.metrics_enabled
  }
}
