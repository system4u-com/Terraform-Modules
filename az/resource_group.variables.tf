variable "resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "unmanaged_resource_groups" {
  description = "List of Unmanaged Resource Group names"
  type = list(string)
  default = []
}