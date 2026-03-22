variable "communication_services" {
    description = "Azure Communication Services"
    type = map(object({
        name = optional(string)
        resource_group = object({
        id       = string
        name     = string
        location = string
        })
        data_location = optional(string) // Location of the Communication Service, default Europe 
        tags = optional(map(string), {})
    }))
  
}