variable "linux_virtual_machines" {
  description = "Linux Virtual Machines"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location                        = optional(string) // Location of the VM, if not specified, it will use the location of the resource group
    size                            = optional(string, "Standard_B2s")
    admin_username                  = optional(string, "adminuser")
    admin_password                  = optional(string, "Ch@ng3m3!")
    disable_password_authentication = optional(bool, false)
    admin_ssh_keys = optional(list(object({
      username   = string
      public_key = string
    })), [])
    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "StandardSSD_LRS")
      disk_size_gb         = optional(number, 64)
    }), {})
    source_image_reference = optional(object({
      publisher = optional(string, "Canonical")
      offer     = optional(string, "ubuntu-24_04-lts")
      sku       = optional(string, "server")
      version   = optional(string, "latest")
    }), {})
    plan = optional(object({
      name      = optional(string)
      publisher = optional(string)
      product   = optional(string)
    }), {})
    network_interface_ids = optional(list(string), [])
    tags                  = optional(map(string), {})
  }))
  default = {}
}

variable "windows_virtual_machines" {
  description = "Windows Virtual Machines"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    location       = optional(string) // Location of the VM, if not specified, it will use the location of the resource group
    size           = optional(string, "Standard_B2s")
    admin_username = optional(string, "adminuser")
    admin_password = optional(string, "Ch@ng3m3!")
    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "StandardSSD_LRS")
      disk_size_gb         = optional(number, 64)
    }), {})
    source_image_reference = optional(object({
      publisher = optional(string, "MicrosoftWindowsServer")
      offer     = optional(string, "WindowsServer")
      sku       = optional(string, "2022-datacenter-g2")
      version   = optional(string, "latest")
    }), {})
    plan = optional(object({
      name      = optional(string, "")
      publisher = optional(string, "")
      product   = optional(string, "")
    }), {})
    license_type          = optional(string, "None") // on-premise license aka Azure Hybrid Use Benefit - None, Windows_Client and Windows_Server
    network_interface_ids = optional(list(string), [])
    tags                  = optional(map(string), {})
  }))
  default = {}
}
