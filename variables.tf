variable "namespace_name" {
  type    = string
  default = null
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "namespace_type" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "enabled" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "hubs_parameters" {
  description = "Map of Notification Hub parameters"
  type = map(object({
    name = string
    apns_credential = optional(object({
      application_mode = string
      bundle_id        = string
      key_id           = string
      team_id          = string
      token            = string
    }))
    gcm_credential = optional(object({
      api_key = string
    }))
  }))
  default = {}
}

variable "azure_ad_groups" {
  description = "Grantees Storage Blob Data Contributor on Static Web Blob $Web. Optional"
  type        = list(string)
  default     = []
}