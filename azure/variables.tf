variable "default_location" {
  description = "Default Location"
  default     = "northeurope"
}

variable "resource_groups" {
  description = "Resource Groups"
  type = map(object({
    location = optional(string, "")
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "public_ips" {
  description = "Public IP Addresses"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    sku               = optional(string, "Standard")
    allocation_method = optional(string, "Static")
    domain_name_label = optional(string, null)
    tags              = optional(map(string), {})
  }))
  default = {}
}

variable "virtual_networks" {
  description = "Virtual Networks"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    address_space = list(string)
    dns_servers   = optional(list(string), [])
    tags          = optional(map(string), {})
  }))
  default = {}
}

variable "subnets" {
  description = "Subnets"
  type = map(object({
    virtual_network = object({
      id                  = string
      name                = string
      location            = string
      resource_group_name = string
    })
    address_prefixes = list(string)
  }))
  default = {}
}

variable "peerings" {
  description = "Virtual Network Peering"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    virtual_network = object({
      id                  = string
      name                = string
      location            = string
      resource_group_name = string
    })
    remote_virtual_network = object({
      id                  = string
      name                = string
      location            = string
      resource_group_name = string
    })
    allow_virtual_network_access = optional(bool, true)
  }))
  default = {}
}

variable "network_security_groups" {
  description = "Network Security Groups"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    subnet_association = optional(object({
      id = string
    }), null)
    nic_association = optional(object({
      id = string
    }), null)
    tags = optional(map(string), {})
    rules = optional(map(object({
      priority                     = string
      direction                    = string                // Inbound | Outbound
      access                       = string                // Allow | Deny
      protocol                     = optional(string, "*") // Tcp | Udp | Icmp | Esp | Ah | *
      source_address_prefix        = optional(string, null)
      source_address_prefixes      = optional(list(string), null)
      source_port_range            = optional(string, null)
      source_port_ranges           = optional(list(string), null)
      destination_address_prefix   = optional(string, null)
      destination_address_prefixes = optional(list(string), null)
      destination_port_range       = optional(string, null)
      destination_port_ranges      = optional(list(string), null)
      description                  = optional(string)
    })), {})
  }))
  default = {}
}

variable "network_interfaces" {
  description = "Network Interfaces"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    ip_configurations = map(object({
      subnet = object({
        id = string
      })
      private_ip_address            = optional(string, null)
      private_ip_address_allocation = optional(string, "Dynamic") // Dynamic | Static
      private_ip_address_version    = optional(string, "IPv4")    // IPv4 | IPv6
      public_ip = optional(object({
        id = string
      }))
    }))
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "linux_virtual_machines" {
  description = "Linux Virtual Machines"
  type = map(object({
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    size                            = optional(string, "Standard_B2s")
    admin_username                  = optional(string, "adminuser")
    admin_password                  = optional(string, null)
    disable_password_authentication = optional(bool, false)
    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "Standard_LRS")
    }), null)
    source_image_reference = optional(object({
      publisher = optional(string, "Canonical")
      offer     = optional(string, "ubuntu-24_04-lts")
      sku       = optional(string, "server")
      version   = optional(string, "latest")
    }), null)
    tags = optional(map(string), {})
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
    size           = optional(string, "Standard_B2s")
    admin_username = optional(string, "adminuser")
    admin_password = optional(string,"P@$$w0rd1234!")
    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "Standard_LRS")
      disk_size_gb         = optional(number, 64)
    }), null)
    source_image_reference = optional(object({
      publisher = optional(string, "MicrosoftWindowsServer")
      offer     = optional(string, "WindowsServer")
      sku       = optional(string, "2022-datacenter-g2")
      version   = optional(string, "latest")
    }), null)
    tags = optional(map(string), {})
  }))
  default = {}
}
