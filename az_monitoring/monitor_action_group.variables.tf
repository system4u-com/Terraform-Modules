variable "monitor_action_groups" {
  description = "Monitor Action Groups"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location   = optional(string)     // Location of the Log Analytics Workspace, if not specified, it will use the location of the resource group
    name       = optional(string)     // Name of the Log Analytics Workspace, if not specified, it will use the key of the map
    short_name = optional(string)     // Short name for the action group, if not specified, it will use the name
    enabled    = optional(bool, true) // Enable or disable the action group
    email_receivers = optional(list(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = optional(bool, true) // Status of the email receiver, default is "Enabled"
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}