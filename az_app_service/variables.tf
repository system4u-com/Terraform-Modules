variable "linux_function_apps" {
  description = "Linux Function Apps"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location = optional(string) // Location of the Function App, if not specified, it will use the location of the resource group
    tags     = optional(map(string), {})
    storage_account = object({
      name = string
    })
    storage_account_access_key = string
    service_plan = object({
      id = string
    })
    https_only   = optional(bool, false)
    app_settings = optional(map(string), {})
    site_config = optional(map(object({
      application_stack = optional(object({
        node_version = optional(string)
      }))
      application_insights_connection_string = optional(string)
    })))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), [])
    }))
    lifecycle = optional(object({
      ignore_changes = optional(list(string), [])
    }))
  }))
  default = {}
}
