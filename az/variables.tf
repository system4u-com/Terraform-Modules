# variable "default_location" {
#   description = "Default Location"
#   default     = "northeurope"
# }

variable "resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
  default = {}
}
