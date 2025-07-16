output "virtual_machine_extensions" {
  value = {
    for k, value in azurerm_virtual_machine_extension.virtual_machine_extensions : k => {
      id                 = value.id
      name               = value.name
      virtual_machine_id = value.virtual_machine_id
      publisher          = value.publisher
      type               = value.type
    }
  }
}