variable "private_dns_records" {
  description = "Private DNS records"
  type = map(object({
    zone_key = string
    type     = string
    name     = string
    ttl      = optional(number, 300)
    record   = optional(string)
    records  = optional(list(string))
    tags     = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for record in var.private_dns_records : contains(["A", "AAAA", "CNAME", "TXT"], upper(record.type))
    ])
    error_message = "Supported private DNS record types are A, AAAA, CNAME and TXT."
  }

  validation {
    condition = alltrue([
      for record in var.private_dns_records : (
        upper(record.type) == "CNAME"
        ? record.record != null && record.records == null
        : record.record == null && record.records != null
      )
    ])
    error_message = "CNAME records must use 'record'; A, AAAA and TXT records must use 'records'."
  }

  validation {
    condition = alltrue([
      for record in var.private_dns_records : (
        upper(record.type) == "CNAME"
        ? true
        : length(record.records) > 0
      )
    ])
    error_message = "A, AAAA and TXT records must contain at least one value in 'records'."
  }
}
