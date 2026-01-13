variable "virtual_machines" {
  description = "Virtual Machines - use only if you really nned them - old style of definition"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location = optional(string) // Location of the VM, if not specified, it will use the location of the resource group
    name     = optional(string)
    vm_size  = optional(string, "Standard_B2s")
    os_profile = optional(object({
      computer_name  = optional(string)              // Name of the computer, if not specified, it will use the name of the VM
      admin_username = optional(string, "adminuser") // Username for the VM
      admin_password = optional(string, "Ch@ng3m3!") // Password for the VM, required for Windows VMs
      custom_data    = optional(string)              // Custom data to be passed to the VM

    }))

    license_type = optional(string, "None") // on-premise license aka Azure Hybrid Use Benefit - None, Windows_Client and Windows_Server
    storage_os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      os_type              = optional(string)
      create_option        = optional(string, "Attach") // Options: FromImage, Attach
      disk_size_gb         = optional(number, 64)
      name = optional(string) // Name of the OS disk, if not specified, it will use the VM name with "-osdisk" suffix
    }), {})

    plan = optional(object({
      name      = optional(string)
      publisher = optional(string)
      product   = optional(string)
    }))
    primary_network_interface_id = optional(string) // Primary network interface ID for the VM
    network_interface_ids = optional(list(string), [])
    boot_diagnostics = optional(object({
      enabled = optional(bool, false) // Enable boot diagnostics
      storage_uri = optional(string)  // Storage URI for boot diagnostics
    }))
    identity = optional(object({
      type         = optional(string) // Type of identity for the VM
      identity_ids = optional(list(string))
    }))
    tags = optional(map(string), {})
  }))
  default = {}
}
