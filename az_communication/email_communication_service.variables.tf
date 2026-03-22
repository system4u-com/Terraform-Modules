variable "email_communication_services" {
  description = "Azure Communication Services for Email"
  type = map(object({
    name = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    data_location = optional(string, "Europe") // Location of the Communication Service, default Europe 
    tags = optional(map(string), {})
  }))
  default = {}  
}