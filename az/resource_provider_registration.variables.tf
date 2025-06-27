variable "resource_provider_registrations" {
  description = "Map of resource provider registrations to be created. The key is the name of the resource provider, and the value is an object containing optional features to register."
  type = map(object({
    name = optional(string)
    features = optional(map(object({
      name       = optional(string)
      registered = optional(bool)
    })), {})
  }))
  default = {}
}