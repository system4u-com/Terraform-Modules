output "data_collection_rules" {
  value = {
    for k, value in azurerm_monitor_data_collection_rule.data_collection_rules : k => {
      id       = value.id
      name     = value.name
      location = value.location
      resource_group_name = value.resource_group_name
      immutable_id = value.immutable_id
    }
  }
}