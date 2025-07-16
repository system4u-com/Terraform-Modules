variable "virtual_machine_extensions" {
  description = "Map of data disks per VM"
  type = map(object({
    name                 = optional(string) // Name of the managed disk, if not specified, it will use the key of the map
    virtual_machine_ids = list(string)
    publisher           = string // Publisher of the VM extension
    type = string // Type of the VM extension
    type_handler_version = string // Version of the VM extension handler
    auto_upgrade_minor_version = optional(bool, true) // Whether to automatically upgrade the minor version
    settings = optional(string) // Settings for the VM extension
    protected_settings = optional(string) // Protected settings for the VM extension
    automatic_upgrade_enabled = optional(bool, false) // Whether to enable automatic upgrade
    tags                 = optional(map(string), {})
  }))
  default = {}
}
