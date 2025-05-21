output "managed_disks" {
  value = {
    for k, value in azurerm_managed_disk.managed_disks : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}