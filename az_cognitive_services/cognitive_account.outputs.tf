output "cognitive_accounts" {
  value = {
    for k, value in azurerm_cognitive_account.cognitive_accounts : k => {
      id       = value.id
      name     = value.name
      location = value.location
      endpoint = value.endpoint
      kind     = value.kind
    }
  }
}
