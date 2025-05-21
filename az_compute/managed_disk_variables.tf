variable "data_disks" {
  description = "Map of data disks per VM"
  type = map(object({
    resource_group_name = string
    location            = string
    disks = list(object({
      name                 = string
      size_gb              = number
      storage_account_type = optional(string,  "Standard_LRS")
      caching              = optional(string,  "ReadWrite")
    }))
  }))
  default = {}
}