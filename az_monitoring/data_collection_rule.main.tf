resource "azurerm_monitor_data_collection_rule" "data_collection_rules" {
  for_each = var.data_collection_rules

  name                        = coalesce(each.value.name, each.key)
  resource_group_name         = each.value.resource_group.name
  location                    = coalesce(each.value.location, each.value.resource_group.location)
  description                 = each.value.description
  data_collection_endpoint_id = each.value.data_collection_endpoint_id
  destinations {
    dynamic "log_analytics" {
      for_each = try(each.value.destinations.log_analytics.workspace_resource_id, null) != null ? [each.value.destinations.log_analytics] : []
      content {
        workspace_resource_id = log_analytics.value.workspace_resource_id
        name                  = log_analytics.value.name
      }
    }
    dynamic "event_hub" {
      for_each = try(each.value.destinations.event_hub.event_hub_id, null) != null ? [each.value.destinations.event_hub] : []
      content {
        event_hub_id = event_hub.value.event_hub_id
        name         = event_hub.value.name
      }
    }
    dynamic "storage_blob" {
      for_each = try(each.value.destinations.storage_blob.storage_account_id, null) != null ? [each.value.destinations.storage_blob] : []
      content {
        storage_account_id = storage_blob.value.storage_account_id
        container_name     = storage_blob.value.container_name
        name               = storage_blob.value.name
      }
    }
    dynamic "azure_monitor_metrics" {
      for_each = try(each.value.destinations.azure_monitor_metrics.name, null) != null ? [each.value.destinations.azure_monitor_metrics] : []
      content {
        name = azure_monitor_metrics.value.name
      }
    }
  }
  dynamic "data_flow" {
    for_each = try(each.value.data_flows, [])
    content {
      streams       = data_flow.value.streams
      destinations  = data_flow.value.destinations
      output_stream = data_flow.value.output_stream
      transform_kql = data_flow.value.transform_kql
    }
  }

  dynamic "data_sources" {
    for_each = try(each.value.data_sources, null) != null ? [each.value.data_sources] : []
    content {
      dynamic "syslog" {
        for_each = try(data_sources.value.syslog, [])
        content {
          facility_names = syslog.value.facility_names
          log_levels     = syslog.value.log_levels
          streams        = syslog.value.streams
          name           = syslog.value.name
        }
      }
      dynamic "performance_counter" {
        for_each = try(data_sources.value.performance_counter, [])
        content {
          streams                       = performance_counter.value.streams
          sampling_frequency_in_seconds = performance_counter.value.sampling_frequency_in_seconds
          counter_specifiers            = performance_counter.value.counter_specifiers
          name                          = performance_counter.value.name
        }
      }
      dynamic "windows_event_log" {
        for_each = try(data_sources.value.windows_event_log, [])
        content {
          streams        = windows_event_log.value.streams
          x_path_queries = windows_event_log.value.x_path_queries
          name           = windows_event_log.value.name
        }
      }
      dynamic "iis_log" {
        for_each = try(data_sources.value.iis_log, [])
        content {
          streams         = iis_log.value.streams
          name            = iis_log.value.name
          log_directories = iis_log.value.log_directories
        }
      }
      dynamic "log_file" {
        for_each = try(data_sources.value.log_file, [])
        content {
          streams       = log_file.value.streams
          name          = log_file.value.name
          file_patterns = log_file.value.file_patterns
          format        = log_file.value.format
          dynamic "settings" {
            for_each = try(log_file.value.settings, null) != null ? [log_file.value.settings] : []
            content {
              dynamic "text" {
                for_each = try(settings.value.text, null) != null ? [settings.value.text] : []
                content {
                  record_start_timestamp_format = text.value.record_start_timestamp_format
                }
              }
            }
          }
        }
      }
      dynamic "extension" {
        for_each = try(data_sources.value.extension, [])
        content {
          streams            = extension.value.streams
          input_data_sources = extension.value.input_data_sources
          name               = extension.value.name
          extension_name     = extension.value.extension_name
          extension_json     = extension.value.extension_json
        }
      }
      dynamic "prometheus_forwarder" {
        for_each = try(data_sources.value.prometheus_forwarder, [])
        content {
          streams = prometheus_forwarder.value.streams
          name    = prometheus_forwarder.value.name
          dynamic "label_include_filter" {
            for_each = try(prometheus_forwarder.value.label_include_filter, [])
            content {
              label = label_include_filter.value.label
              value = label_include_filter.value.value
            }
          }
        }
      }
    }
  }

  tags = each.value.tags
}

resource "azurerm_monitor_data_collection_rule_association" "data_collection_rule_associations" {
  for_each = {
    for item in flatten([
      for assoc_key, assoc_value in var.data_collection_rule_associations : [
        for idx, target_resource_id in assoc_value.target_resource_ids : {
          key                     = "${assoc_key}-${split("/", target_resource_id)[length(split("/", target_resource_id)) - 1]}" // Result like <rule-name>-<resource-name> --> dcr-uis-vmmetrics-cae-uis-azrvmsqli1t
          name                    = coalesce(assoc_value.name, assoc_key)
          target_resource_id      = target_resource_id
          data_collection_rule_id = assoc_value.data_collection_rule_id
        }
      ]
    ]) : item.key => item
  }

  name                    = "${each.value.name}-${split("/", each.value.target_resource_id)[length(split("/", each.value.target_resource_id)) - 1]}"
  target_resource_id      = each.value.target_resource_id
  data_collection_rule_id = each.value.data_collection_rule_id
}