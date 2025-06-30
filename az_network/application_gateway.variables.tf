variable "application_gateways" {
  description = "Applications Gateways"
  type = map(object({
    name     = optional(string)
    location = optional(string)
    resource_group = object({
      id       = string
      name     = string
      location = string
    })
    sku = object({
      name     = string
      tier     = string
      capacity = string
    })
    gateway_ip_configurations = map(object({
      subnet_id = optional(string)
    }))
    frontend_ports = map(object({
      port = optional(string)
    }))
    frontend_ip_configurations = map(object({
      private_ip_address            = optional(string)
      private_ip_address_allocation = optional(string)
      public_ip_address_id          = optional(string)
      subnet_id                     = optional(string)
    }))
    backend_address_pools = map(object({
      ip_addresses = optional(list(string))
    }))
    backend_http_settings = map(object({
      cookie_based_affinity = optional(string)
      path                  = optional(string)
      port                  = optional(string)
      protocol              = optional(string)
      request_timeout       = optional(string)
    }))
    http_listeners = map(object({
      frontend_ip_configuration_name = optional(string)
      frontend_port_name             = optional(string)
      protocol                       = optional(string)
      require_sni                    = optional(bool, false)
      host_name                      = optional(string)
      ssl_certificate_name           = optional(string)
    }))
    request_routing_rules = map(object({
      priority                    = optional(string)
      rule_type                   = optional(string)
      http_listener_name          = optional(string)
      backend_address_pool_name   = optional(string)
      backend_http_settings_name  = optional(string)
      redirect_configuration_name = optional(string)
    }))
    redirect_configurations = map(object({
      redirect_type        = string(optional)
      target_listener_name = string(optional)
      include_path         = string(bool)
      include_query_string = string(bool)
    }))
    rewrite_rule_set = map(object({
      rewrite_rule = map(object({
        rule_sequence = string(optional)
        response_header_configuration = map(object({
          header_name = string(optional)
          header_value = string(optional)
        }))
      }))
    }))
    waf_configuration = object({
      enabled          = bool
      firewall_mode    = string
      rule_set_type    = optional(string)
      rule_set_version = optional(string)
      # disabled_rule_group = object ({
      #   rule_group_name   = optional(string)
      # })
    })
    tags = optional(map(string), {})
  }))
  default = {}
}
