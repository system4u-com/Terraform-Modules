resource "azurerm_application_gateway" "application_gateways" {
  for_each = var.application_gateways

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name

  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    capacity = each.value.sku.capacity
  }

  dynamic "gateway_ip_configuration" {
    for_each = each.value.gateway_ip_configurations
    content {
      name      = gateway_ip_configuration.key
      subnet_id = gateway_ip_configuration.value.subnet_id
    }
  }

  dynamic "frontend_port" {
    for_each = each.value.frontend_ports
    content {
      name = frontend_port.key
      port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configurations
    content {
      name                          = frontend_ip_configuration.key
      private_ip_address            = frontend_ip_configuration.value.private_ip_address
      private_ip_address_allocation = frontend_ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = frontend_ip_configuration.value.public_ip_address_id
      subnet_id                     = frontend_ip_configuration.value.subnet_id
    }
  }

  dynamic "backend_address_pool" {
    for_each = each.value.backend_address_pools
    content {
      name         = backend_address_pool.key
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = each.value.backend_http_settings
    content {
      name                  = backend_http_settings.key
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      path                  = backend_http_settings.value.path
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout
    }
  }

  dynamic "http_listener" {
    for_each = each.value.http_listeners
    content {
      name                           = http_listener.key
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      require_sni                    = http_listener.value.require_sni
      host_name                      = http_listener.value.host_name
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
    }
  }

  dynamic "request_routing_rule" {
    for_each = each.value.request_routing_rules
    content {
      name                        = request_routing_rule.key
      priority                    = request_routing_rule.value.priority
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.backend_http_settings_name
      redirect_configuration_name = request_routing_rule.value.redirect_configuration_name
    }
  }

  dynamic "redirect_configuration" {
    for_each = each.value.redirect_configuration
    content {
      name                 = redirect_configuration.key
      redirect_type        = redirect_configuration.value.redirect_type
      target_listener_name = redirect_configuration.value.target_listener_name
      include_path         = redirect_configuration.value.include_path
      include_query_string = redirect_configuration.value.include_query_string
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = each.value.rewrite_rule_set
    content {
      name                 = rewrite_rule_set.key
      dynamic "rewrite_rule" {
        for_each = each.value.rewrite_rule
        content {
          name = rewrite_rule.key
          rule_sequence = rewrite_rule.value.rule_sequence
          dynamic "response_header_configuration" {
            for_each = each.value.response_header_configuration
            content {
              header_name = response_header_configuration.value.header_name
              header_value = response_header_configuration.value.header_value
            }
            
          }
        }
        
      }
    }
  }

  waf_configuration {
    enabled          = each.value.waf_configuration.enabled
    firewall_mode    = each.value.waf_configuration.firewall_mode
    rule_set_type    = each.value.waf_configuration.rule_set_type
    rule_set_version = each.value.waf_configuration.rule_set_version
    # disabled_rule_group {
    #   rule_group_name = disabled_rule_group.rule_group_name.value
    # }
  }
}
