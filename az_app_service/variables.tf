variable "service_plans" {
  description = "App Service Plans"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location = optional(string) // Location of the App Service Plan, if not specified, it will use the location of the resource group
    os_type  = optional(string, "Linux")
    sku_name = optional(string, "Y1")
    tags     = optional(map(string), {})
  }))
  default = {}
}