variable "windows_function_apps" {
  description = "Windows Function Apps"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location = optional(string)
    tags     = optional(map(string), {})
    storage_account = object({
      name = optional(string)
    })
    storage_account_access_key = optional(string)
    service_plan = object({
      id = string
    })
    https_only                  = optional(bool, true)
    functions_extension_version = optional(string, "~4")
    app_settings                = optional(map(string), {})
    site_config = optional(object({
      application_stack = optional(object({
        powershell_core_version = optional(string, null)
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