output "storage_syncs" {
    value = {
    for k, value in azurerm_storage_sync.storage_syncs : k => {
      id       = value.id
      name     = value.name
      location = value.location
      incomming_traffic_policy = value.incoming_traffic_policy
    }
  }
  
}