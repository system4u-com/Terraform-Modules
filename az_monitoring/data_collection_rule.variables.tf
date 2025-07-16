variable "data_collection_rules" {
  description = "Monitor Data Collection Rules"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name       = optional(string)     // Name of the Log Analytics Workspace, if not specified, it will use the key of the map
    location   = optional(string)     // Location of the Log Analytics Workspace, if not specified, it will use the location of the resource group
    data_collection_endpoint_id = optional(string) // ID of the data collection endpoint to use, if not specified, it will use the default endpoint
    description = optional(string) // Description of the data collection rule
    destinations = optional(object({
      log_analytics = optional(object({
        workspace_resource_id = optional(string) // Resource ID of the Log Analytics Workspace
        name                  = optional(string) // Name of the destination
      }), {})
      event_hub = optional(object({
        event_hub_id        = optional(string) // Name of the Event Hub
        name                  = optional(string) // Name of the destination
      }), {})
      storage_blob = optional(object({
        storage_account_id = optional(string) // Resource ID of the Storage Account
        container_name = optional(string) // Name of the Storage Blob Container
        name               = optional(string) // Name of the destination
      }), {})
      azure_monitor_metrics = optional(object({
        name = optional(string) // Name of the destination
      }), {}) 
    }), {})  
    data_flows = optional(list(object({
      streams      = optional(list(string)) // List of streams to collect data from
      destinations = optional(list(string)) // List of destination names to send data to
      output_stream = optional(string)
      transform_kql = optional(string) // KQL query to transform the data
    })), [])
    data_sources = optional(object({
      syslog = optional(list(object({
        facility_names = optional(list(string), []) // List of syslog facility names to collect
        log_levels = optional(list(string), []) // List of syslog log levels to collect
        streams = optional(list(string), []) // List of streams to collect syslog data from
        name = optional(string) // Name of the syslog data source
      })), [])
      performance_counter = optional(list(object({
        streams                       = list(string) // List of streams to collect performance counters from
        sampling_frequency_in_seconds = optional(number, 60) // Sampling frequency in seconds
        counter_specifiers = list(string) // List of counter specifiers
        name = optional(string) // Name of the performance counter data source
      })), [])
      windows_event_log = optional(list(object({
        streams        = list(string) // List of streams to collect Windows event logs from
        x_path_queries = list(string) // List of XPath queries to filter Windows event logs
        name           = optional(string) // Name of the Windows event log data source
      })), [])
      iis_log = optional(list(object({
        streams = list(string) // List of streams to collect IIS logs from
        name    = optional(string) // Name of the IIS log data source
        log_directories = optional(list(string), []) // List of IIS log directories
      })), [])
      log_file = optional(list(object({
        streams = list(string) // List of streams to collect log files from
        name    = optional(string) // Name of the log file data source
        file_patterns = list(string) // List of file patterns to match log files
        format = string // Format of the log file (e.g., "text")
        settings = optional(object({
          text = optional(object({
            record_start_timestamp_format = optional(string) // Timestamp format for log records
          }), {})
        }), {})
      })), [])
      extension = optional(list(object({
        streams            = list(string) // List of streams for extension data source
        input_data_sources = list(string) // List of input data sources
        name               = optional(string) // Name of the extension data source
        extension_name     = string // Name of the extension
        extension_json     = optional(string) // JSON configuration for the extension
      })), [])
      prometheus_forwarder = optional(list(object({
        streams = list(string) // List of streams for Prometheus forwarder
        name    = optional(string) // Name of the Prometheus forwarder data source
        label_include_filter = optional(list(object({
          label = string // Label name to include
          value = string // Label value to include
        })), [])
      })), [])
    }), {})
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "data_collection_rule_associations" {
  description = "Map of Data Collection Rule Associations"
  type = map(object({
    name                    = optional(string) // Name of the Data Collection Rule Association, if not specified, it will use the key of the map
    target_resource_ids     = list(string) // Resource IDs of the target resources to associate with the data collection rule
    data_collection_rule_id = string // Full Azure resource ID of the data collection rule
  }))
  default = {}
}