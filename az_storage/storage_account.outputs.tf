output "storage_accounts" {
  value = {
    for k, value in azurerm_storage_account.storage_accounts : k => {
      id       = value.id
      name     = value.name
      location = value.location
      primary_access_key = value.primary_access_key
    }
  }
  
}

output "storage_accounts_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.storage_accounts_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      metrics                   = value.metric
    }
  }
}

output "storage_accounts_blobs_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.storage_accounts_blobs_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
}

output "storage_accounts_queues_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.storage_accounts_queues_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
}

output "storage_accounts_tables_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.storage_accounts_tables_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
}

output "storage_accounts_files_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.storage_accounts_files_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
  
}