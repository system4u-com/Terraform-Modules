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
      name = optional(string)
    })
    storage_account_access_key    = optional(string)
    storage_uses_managed_identity = optional(bool, true)
    service_plan = object({
      id = string
    })
    https_only   = optional(bool, true)
    app_settings = optional(map(string), {})
    site_config = optional(object({
      application_stack = optional(object({
        node_version             = optional(string, null)
        python_version           = optional(string, null)
        java_version             = optional(string, null)
        dotnet_version           = optional(string, null)
        powershell_core_version  = optional(string, null)
      }))
      application_insights_connection_string = optional(string)
    }), {})
    identity = optional(object({
      type         = optional(string)
      identity_ids = optional(list(string))
    }))
  }))
  default = {}
}
