output "storage_shares" {
    value = {
    for k, value in azurerm_storage_share.storage_shares : k => {
      id               = value.id
      name             = value.name
      storage_account_id = value.storage_account_id
      quota            = value.quota
      access_tier      = value.access_tier
      metadata         = value.metadata
      enabled_protocol = value.enabled_protocol
    }
    }
  
}