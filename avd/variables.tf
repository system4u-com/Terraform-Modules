variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "name_suffix_format" {
  description = "Suffix for formatted host names"
  type        = string
  default     = "%02d"
}