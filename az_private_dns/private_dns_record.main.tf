resource "azurerm_private_dns_a_record" "private_dns_records" {
  for_each = {
    for k, value in var.private_dns_records : k => value
    if upper(value.type) == "A"
  }

  name                = each.value.name
  private_dns_zone_id = local.private_dns_zones[each.value.zone_key].id
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_private_dns_aaaa_record" "private_dns_records" {
  for_each = {
    for k, value in var.private_dns_records : k => value
    if upper(value.type) == "AAAA"
  }

  name                = each.value.name
  private_dns_zone_id = local.private_dns_zones[each.value.zone_key].id
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_private_dns_cname_record" "private_dns_records" {
  for_each = {
    for k, value in var.private_dns_records : k => value
    if upper(value.type) == "CNAME"
  }

  name                = each.value.name
  private_dns_zone_id = local.private_dns_zones[each.value.zone_key].id
  ttl                 = each.value.ttl
  record              = each.value.record
  tags                = each.value.tags
}

resource "azurerm_private_dns_txt_record" "private_dns_records" {
  for_each = {
    for k, value in var.private_dns_records : k => value
    if upper(value.type) == "TXT"
  }

  name                = each.value.name
  private_dns_zone_id = local.private_dns_zones[each.value.zone_key].id
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value
    }
  }
}
