output "private_dns_records" {
  value = merge(
    {
      for k, value in azurerm_private_dns_a_record.private_dns_records : k => {
        id                  = value.id
        name                = value.name
        type                = "A"
        fqdn                = value.fqdn
        private_dns_zone_id = value.private_dns_zone_id
        ttl                 = value.ttl
        records             = value.records
      }
    },
    {
      for k, value in azurerm_private_dns_aaaa_record.private_dns_records : k => {
        id                  = value.id
        name                = value.name
        type                = "AAAA"
        fqdn                = value.fqdn
        private_dns_zone_id = value.private_dns_zone_id
        ttl                 = value.ttl
        records             = value.records
      }
    },
    {
      for k, value in azurerm_private_dns_cname_record.private_dns_records : k => {
        id                  = value.id
        name                = value.name
        type                = "CNAME"
        fqdn                = value.fqdn
        private_dns_zone_id = value.private_dns_zone_id
        ttl                 = value.ttl
        record              = value.record
      }
    },
    {
      for k, value in azurerm_private_dns_txt_record.private_dns_records : k => {
        id                  = value.id
        name                = value.name
        type                = "TXT"
        fqdn                = value.fqdn
        private_dns_zone_id = value.private_dns_zone_id
        ttl                 = value.ttl
        records             = [for record in value.record : record.value]
      }
    }
  )
}
