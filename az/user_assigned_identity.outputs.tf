output "user_assigned_identities" {
  value = {
    for k, value in azurerm_user_assigned_identity.user_assigned_identities : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}