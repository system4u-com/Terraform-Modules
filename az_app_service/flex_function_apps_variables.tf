variable "flex_function_apps" {
  description = "Flex Function Apps"
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
    storage_container_type = string
    storage_container_endpoint = string
    storage_authentication_type = string // StorageAccountConnectionString | SystemAssignedIdentity | UserAssignedIdentity
    runtime_name = string
    runtime_version = string
    service_plan = object({
      id = string
    })
    site_config = object({
      name = string
    })
    
  }))
  default = {}
  
}