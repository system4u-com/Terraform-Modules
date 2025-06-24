output "key_vaults" {
  value = {
    for k, value in azurerm_key_vault.key_vaults : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
  
}