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
    storage_uses_managed_identity = optional(bool, false)
    service_plan = object({
      id = string
    })
    https_only                  = optional(bool, true)
    functions_extension_version = optional(string, "~4")
    app_settings                = optional(map(string), {})
    site_config = optional(object({
      application_stack = optional(object({
        dotnet_version              = optional(string, null)
        use_dotnet_isolated_runtime = optional(bool, null)
        java_version                = optional(string, null)
        node_version                = optional(string, null)
        powershell_core_version     = optional(string, null)
        use_custom_runtime          = optional(bool, null)
      }))
      application_insights_connection_string = optional(string)
    }), {})
    identity = optional(object({
      type         = optional(string)
      identity_ids = optional(list(string))
    }))
  }))

  validation {
    condition = alltrue([
      for app in values(var.windows_function_apps) : try(app.storage_account.name, null) != null && trim(try(app.storage_account.name, "")) != ""
    ])
    error_message = "Each windows_function_apps item must define storage_account.name."
  }

  validation {
    condition = alltrue([
      for app in values(var.windows_function_apps) : try(app.storage_uses_managed_identity, false) != (try(app.storage_account_access_key, null) != null && trim(try(app.storage_account_access_key, "")) != "")
    ])
    error_message = "Each windows_function_apps item must set exactly one of storage_account_access_key or storage_uses_managed_identity = true."
  }

  default = {}
}