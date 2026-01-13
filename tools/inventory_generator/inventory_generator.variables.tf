variable "ansible_groups_tag" {
  description = "Tag name that holds comma-separated Ansible group names."
  type        = string
  default     = "Ans_Groups"
}

variable "az_compute" {
  description = "Map/object of VM outputs (e.g., module.az_compute)."
  type        = any
}

variable "output_path" {
  description = "Where to write the generated inventory file."
  type        = string
  default     = null
}
