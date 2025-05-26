variable "hosts" {
  description = "List of AVD hosts"
  type = map(object({
    location = optional(string)
    resource_group = object({
      name     = string
      location = string
    })
    host_count     = optional(number, 1)
    subnet_id      = string
    name_preffix   = string
    size           = optional(string, "Standard_B2s")
    admin_username = optional(string, "adminuser")
    admin_password = optional(string, "Ch@ng3m3!")
    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "StandardSSD_LRS")
      disk_size_gb         = optional(number, 128)
    }), {})
    source_image_reference = optional(object({
      publisher = optional(string, "MicrosoftWindowsDesktop")
      offer     = optional(string, "windows-11")
      sku       = optional(string, "win11-22h2-avd")
      version   = optional(string, "latest")
    }), {})
    license_type = optional(string, "None")
    domain_join_type = optional(string, "entra-join")
    host_pool_name = optional(string)
    tags         = optional(map(string), {})
  }))
  default = {}
}
