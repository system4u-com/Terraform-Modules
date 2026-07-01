output "cognitive_account_projects" {
  value = {
    for k, value in azurerm_cognitive_account_project.cognitive_account_projects : k => {
      id          = value.id
      name        = value.name
      location    = value.location
      default     = value.default
      endpoints   = value.endpoints
      principal_id = try(value.identity[0].principal_id, null)
      tenant_id    = try(value.identity[0].tenant_id, null)
    }
  }
}
