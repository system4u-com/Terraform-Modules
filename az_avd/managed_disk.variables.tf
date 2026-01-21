variable "managed_disks" {
  description = "Map of data disks per VM"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    name                 = optional(string) // Name of the managed disk, if not specified, it will use the key of the map
    location             = optional(string) // Location of the VM, if not specified, it will use the location of the resource group
    storage_account_type = optional(string, "Standard_LRS")
    create_option        = optional(string, "Empty")
    disk_size_gb         = optional(number, 32)
    tags                 = optional(map(string), {})
  }))
  default = {}
}

variable "vm_data_disks_attachments" {
  description = "Map of managed disks attachments per VM"
  type = map(object({
    managed_disk_id    = string
    virtual_machine_id = string
    lun                = number
    caching            = optional(string, "ReadWrite")
    create_option      = optional(string, "Attach")
  }))
  default = {}
}
