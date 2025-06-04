output "recovery_services_vaults" {
  value = {
    for k, value in azurerm_recovery_services_vault.recovery_services_vaults : k => {
      id                   = value.id
      name                 = value.name
      resource_group_name  = value.resource_group_name
    }
  }
}