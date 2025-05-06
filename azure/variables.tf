variable "azure_default_location" {
    description = "Default Location"
    default = "northeurope"
}

variable "azure_resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = optional(string, "")
    tags = optional(map(string), {})
  }))
  default = {}
}