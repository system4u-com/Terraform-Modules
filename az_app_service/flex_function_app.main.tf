resource "azurerm_function_app_flex_consumption" "flex_function_apps" {
  for_each = var.flex_function_apps

  name                = coalesce(each.value.name, each.key)
  resource_group_name = each.value.resource_group.name
  location            = coalesce(each.value.location, each.value.resource_group.location)
  service_plan_id     = each.value.service_plan.id

  storage_container_type            = each.value.storage_container_type
  storage_container_endpoint        = each.value.storage_container_endpoint
  storage_authentication_type       = each.value.storage_authentication_type
  storage_access_key                = try(each.value.storage_access_key, null)
  storage_user_assigned_identity_id = try(each.value.storage_user_assigned_identity_id, null)
  runtime_name                      = each.value.runtime_name
  runtime_version                   = each.value.runtime_version
  maximum_instance_count            = try(each.value.maximum_instance_count, null)
  instance_memory_in_mb             = each.value.instance_memory_in_mb
  http_concurrency                  = try(each.value.http_concurrency, null)

  app_settings                                   = each.value.app_settings
  enabled                                        = each.value.enabled
  public_network_access_enabled                  = each.value.public_network_access_enabled
  https_only                                     = each.value.https_only
  client_certificate_enabled                     = try(each.value.client_certificate_enabled, null)
  client_certificate_mode                        = try(each.value.client_certificate_mode, null)
  client_certificate_exclusion_paths             = try(each.value.client_certificate_exclusion_paths, null)
  virtual_network_subnet_id                      = try(each.value.virtual_network_subnet_id, null)
  webdeploy_publish_basic_authentication_enabled = each.value.webdeploy_publish_basic_authentication_enabled
  zip_deploy_file                                = try(each.value.zip_deploy_file, null)
  tags                                           = each.value.tags

  site_config {
    api_definition_url                            = try(each.value.site_config.api_definition_url, null)
    api_management_api_id                         = try(each.value.site_config.api_management_api_id, null)
    app_command_line                              = try(each.value.site_config.app_command_line, null)
    container_registry_managed_identity_client_id = try(each.value.site_config.container_registry_managed_identity_client_id, null)
    container_registry_use_managed_identity       = try(each.value.site_config.container_registry_use_managed_identity, null)
    default_documents                             = try(each.value.site_config.default_documents, null)
    health_check_path                             = try(each.value.site_config.health_check_path, null)
    health_check_eviction_time_in_min             = try(each.value.site_config.health_check_eviction_time_in_min, null)
    http2_enabled                                 = try(each.value.site_config.http2_enabled, null)
    ip_restriction_default_action                 = try(each.value.site_config.ip_restriction_default_action, null)
    load_balancing_mode                           = try(each.value.site_config.load_balancing_mode, null)
    managed_pipeline_mode                         = try(each.value.site_config.managed_pipeline_mode, null)
    minimum_tls_version                           = try(each.value.site_config.minimum_tls_version, null)
    remote_debugging_enabled                      = try(each.value.site_config.remote_debugging_enabled, null)
    remote_debugging_version                      = try(each.value.site_config.remote_debugging_version, null)
    runtime_scale_monitoring_enabled              = try(each.value.site_config.runtime_scale_monitoring_enabled, null)
    scm_ip_restriction_default_action             = try(each.value.site_config.scm_ip_restriction_default_action, null)
    scm_minimum_tls_version                       = try(each.value.site_config.scm_minimum_tls_version, null)
    scm_use_main_ip_restriction                   = try(each.value.site_config.scm_use_main_ip_restriction, null)
    use_32_bit_worker                             = try(each.value.site_config.use_32_bit_worker, null)
    vnet_route_all_enabled                        = try(each.value.site_config.vnet_route_all_enabled, null)
    websockets_enabled                            = try(each.value.site_config.websockets_enabled, null)
    worker_count                                  = try(each.value.site_config.worker_count, null)

    dynamic "cors" {
      for_each = try(each.value.site_config.cors, null) != null ? [each.value.site_config.cors] : []
      content {
        allowed_origins     = try(cors.value.allowed_origins, null)
        support_credentials = try(cors.value.support_credentials, null)
      }
    }

    dynamic "ip_restriction" {
      for_each = try(each.value.site_config.ip_restriction, [])
      content {
        action                    = try(ip_restriction.value.action, null)
        ip_address                = try(ip_restriction.value.ip_address, null)
        name                      = try(ip_restriction.value.name, null)
        priority                  = try(ip_restriction.value.priority, null)
        service_tag               = try(ip_restriction.value.service_tag, null)
        virtual_network_subnet_id = try(ip_restriction.value.virtual_network_subnet_id, null)
        description               = try(ip_restriction.value.description, null)
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = try(each.value.site_config.scm_ip_restriction, [])
      content {
        action                    = try(scm_ip_restriction.value.action, null)
        ip_address                = try(scm_ip_restriction.value.ip_address, null)
        name                      = try(scm_ip_restriction.value.name, null)
        priority                  = try(scm_ip_restriction.value.priority, null)
        service_tag               = try(scm_ip_restriction.value.service_tag, null)
        virtual_network_subnet_id = try(scm_ip_restriction.value.virtual_network_subnet_id, null)
        description               = try(scm_ip_restriction.value.description, null)
      }
    }

    dynamic "app_service_logs" {
      for_each = try(each.value.site_config.app_service_logs, null) != null ? [each.value.site_config.app_service_logs] : []
      content {
        disk_quota_mb         = try(app_service_logs.value.disk_quota_mb, null)
        retention_period_days = try(app_service_logs.value.retention_period_days, null)
      }
    }
  }

  dynamic "always_ready" {
    for_each = try(each.value.always_ready, [])
    content {
      name           = always_ready.value.name
      instance_count = try(always_ready.value.instance_count, null)
    }
  }

  dynamic "connection_string" {
    for_each = try(each.value.connection_string, [])
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = try(each.value.identity, null) != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "sticky_settings" {
    for_each = try(each.value.sticky_settings, null) != null ? [each.value.sticky_settings] : []
    content {
      app_setting_names       = try(sticky_settings.value.app_setting_names, null)
      connection_string_names = try(sticky_settings.value.connection_string_names, null)
    }
  }

  dynamic "auth_settings" {
    for_each = try(each.value.auth_settings, null) != null ? [each.value.auth_settings] : []
    content {
      enabled                        = auth_settings.value.enabled
      additional_login_parameters    = try(auth_settings.value.additional_login_parameters, null)
      allowed_external_redirect_urls = try(auth_settings.value.allowed_external_redirect_urls, null)
      default_provider               = try(auth_settings.value.default_provider, null)
      issuer                         = try(auth_settings.value.issuer, null)
      runtime_version                = try(auth_settings.value.runtime_version, null)
      token_refresh_extension_hours  = try(auth_settings.value.token_refresh_extension_hours, null)
      token_store_enabled            = try(auth_settings.value.token_store_enabled, null)
      unauthenticated_client_action  = try(auth_settings.value.unauthenticated_client_action, null)

      dynamic "active_directory" {
        for_each = try(auth_settings.value.active_directory, null) != null ? [auth_settings.value.active_directory] : []
        content {
          client_id                  = active_directory.value.client_id
          allowed_audiences          = try(active_directory.value.allowed_audiences, null)
          client_secret              = try(active_directory.value.client_secret, null)
          client_secret_setting_name = try(active_directory.value.client_secret_setting_name, null)
        }
      }

      dynamic "facebook" {
        for_each = try(auth_settings.value.facebook, null) != null ? [auth_settings.value.facebook] : []
        content {
          app_id                  = facebook.value.app_id
          app_secret              = try(facebook.value.app_secret, null)
          app_secret_setting_name = try(facebook.value.app_secret_setting_name, null)
          oauth_scopes            = try(facebook.value.oauth_scopes, null)
        }
      }

      dynamic "github" {
        for_each = try(auth_settings.value.github, null) != null ? [auth_settings.value.github] : []
        content {
          client_id                  = github.value.client_id
          client_secret              = try(github.value.client_secret, null)
          client_secret_setting_name = try(github.value.client_secret_setting_name, null)
          oauth_scopes               = try(github.value.oauth_scopes, null)
        }
      }

      dynamic "google" {
        for_each = try(auth_settings.value.google, null) != null ? [auth_settings.value.google] : []
        content {
          client_id                  = google.value.client_id
          client_secret              = try(google.value.client_secret, null)
          client_secret_setting_name = try(google.value.client_secret_setting_name, null)
          oauth_scopes               = try(google.value.oauth_scopes, null)
        }
      }

      dynamic "microsoft" {
        for_each = try(auth_settings.value.microsoft, null) != null ? [auth_settings.value.microsoft] : []
        content {
          client_id                  = microsoft.value.client_id
          client_secret              = try(microsoft.value.client_secret, null)
          client_secret_setting_name = try(microsoft.value.client_secret_setting_name, null)
          oauth_scopes               = try(microsoft.value.oauth_scopes, null)
        }
      }

      dynamic "twitter" {
        for_each = try(auth_settings.value.twitter, null) != null ? [auth_settings.value.twitter] : []
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = try(twitter.value.consumer_secret, null)
          consumer_secret_setting_name = try(twitter.value.consumer_secret_setting_name, null)
        }
      }
    }
  }

  dynamic "auth_settings_v2" {
    for_each = try(each.value.auth_settings_v2, null) != null ? [each.value.auth_settings_v2] : []
    content {
      auth_enabled                            = try(auth_settings_v2.value.auth_enabled, null)
      config_file_path                        = try(auth_settings_v2.value.config_file_path, null)
      default_provider                        = try(auth_settings_v2.value.default_provider, null)
      excluded_paths                          = try(auth_settings_v2.value.excluded_paths, null)
      forward_proxy_convention                = try(auth_settings_v2.value.forward_proxy_convention, null)
      forward_proxy_custom_host_header_name   = try(auth_settings_v2.value.forward_proxy_custom_host_header_name, null)
      forward_proxy_custom_scheme_header_name = try(auth_settings_v2.value.forward_proxy_custom_scheme_header_name, null)
      http_route_api_prefix                   = try(auth_settings_v2.value.http_route_api_prefix, null)
      require_authentication                  = try(auth_settings_v2.value.require_authentication, null)
      require_https                           = try(auth_settings_v2.value.require_https, null)
      runtime_version                         = try(auth_settings_v2.value.runtime_version, null)
      unauthenticated_action                  = try(auth_settings_v2.value.unauthenticated_action, null)

      dynamic "active_directory_v2" {
        for_each = try(auth_settings_v2.value.active_directory_v2, null) != null ? [auth_settings_v2.value.active_directory_v2] : []
        content {
          client_id                            = active_directory_v2.value.client_id
          tenant_auth_endpoint                 = active_directory_v2.value.tenant_auth_endpoint
          allowed_applications                 = try(active_directory_v2.value.allowed_applications, null)
          allowed_audiences                    = try(active_directory_v2.value.allowed_audiences, null)
          allowed_groups                       = try(active_directory_v2.value.allowed_groups, null)
          allowed_identities                   = try(active_directory_v2.value.allowed_identities, null)
          client_secret_certificate_thumbprint = try(active_directory_v2.value.client_secret_certificate_thumbprint, null)
          client_secret_setting_name           = try(active_directory_v2.value.client_secret_setting_name, null)
          jwt_allowed_client_applications      = try(active_directory_v2.value.jwt_allowed_client_applications, null)
          jwt_allowed_groups                   = try(active_directory_v2.value.jwt_allowed_groups, null)
          login_parameters                     = try(active_directory_v2.value.login_parameters, null)
          www_authentication_disabled          = try(active_directory_v2.value.www_authentication_disabled, null)
        }
      }

      dynamic "apple_v2" {
        for_each = try(auth_settings_v2.value.apple_v2, null) != null ? [auth_settings_v2.value.apple_v2] : []
        content {
          client_id                  = apple_v2.value.client_id
          client_secret_setting_name = apple_v2.value.client_secret_setting_name
        }
      }

      dynamic "azure_static_web_app_v2" {
        for_each = try(auth_settings_v2.value.azure_static_web_app_v2, null) != null ? [auth_settings_v2.value.azure_static_web_app_v2] : []
        content {
          client_id = azure_static_web_app_v2.value.client_id
        }
      }

      dynamic "custom_oidc_v2" {
        for_each = try(auth_settings_v2.value.custom_oidc_v2, [])
        content {
          name                          = custom_oidc_v2.value.name
          client_id                     = custom_oidc_v2.value.client_id
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          name_claim_type               = try(custom_oidc_v2.value.name_claim_type, null)
          scopes                        = try(custom_oidc_v2.value.scopes, null)
        }
      }

      dynamic "facebook_v2" {
        for_each = try(auth_settings_v2.value.facebook_v2, null) != null ? [auth_settings_v2.value.facebook_v2] : []
        content {
          app_id                  = facebook_v2.value.app_id
          app_secret_setting_name = facebook_v2.value.app_secret_setting_name
          graph_api_version       = try(facebook_v2.value.graph_api_version, null)
          login_scopes            = try(facebook_v2.value.login_scopes, null)
        }
      }

      dynamic "github_v2" {
        for_each = try(auth_settings_v2.value.github_v2, null) != null ? [auth_settings_v2.value.github_v2] : []
        content {
          client_id                  = github_v2.value.client_id
          client_secret_setting_name = github_v2.value.client_secret_setting_name
          login_scopes               = try(github_v2.value.login_scopes, null)
        }
      }

      dynamic "google_v2" {
        for_each = try(auth_settings_v2.value.google_v2, null) != null ? [auth_settings_v2.value.google_v2] : []
        content {
          client_id                  = google_v2.value.client_id
          client_secret_setting_name = google_v2.value.client_secret_setting_name
          allowed_audiences          = try(google_v2.value.allowed_audiences, null)
          login_scopes               = try(google_v2.value.login_scopes, null)
        }
      }

      dynamic "login" {
        for_each = [auth_settings_v2.value.login]
        content {
          allowed_external_redirect_urls    = try(login.value.allowed_external_redirect_urls, null)
          cookie_expiration_convention      = try(login.value.cookie_expiration_convention, null)
          cookie_expiration_time            = try(login.value.cookie_expiration_time, null)
          logout_endpoint                   = try(login.value.logout_endpoint, null)
          nonce_expiration_time             = try(login.value.nonce_expiration_time, null)
          preserve_url_fragments_for_logins = try(login.value.preserve_url_fragments_for_logins, null)
          token_refresh_extension_time      = try(login.value.token_refresh_extension_time, null)
          token_store_enabled               = try(login.value.token_store_enabled, null)
          token_store_path                  = try(login.value.token_store_path, null)
          token_store_sas_setting_name      = try(login.value.token_store_sas_setting_name, null)
          validate_nonce                    = try(login.value.validate_nonce, null)
        }
      }

      dynamic "microsoft_v2" {
        for_each = try(auth_settings_v2.value.microsoft_v2, null) != null ? [auth_settings_v2.value.microsoft_v2] : []
        content {
          client_id                  = microsoft_v2.value.client_id
          client_secret_setting_name = microsoft_v2.value.client_secret_setting_name
          allowed_audiences          = try(microsoft_v2.value.allowed_audiences, null)
          login_scopes               = try(microsoft_v2.value.login_scopes, null)
        }
      }

      dynamic "twitter_v2" {
        for_each = try(auth_settings_v2.value.twitter_v2, null) != null ? [auth_settings_v2.value.twitter_v2] : []
        content {
          consumer_key                 = twitter_v2.value.consumer_key
          consumer_secret_setting_name = twitter_v2.value.consumer_secret_setting_name
        }
      }
    }
  }
}
