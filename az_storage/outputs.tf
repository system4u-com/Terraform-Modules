output "storage_accounts" {
  value = {
    for k, value in azurerm_storage_account.storage_accounts : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
  
}