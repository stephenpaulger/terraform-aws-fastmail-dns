variable "zone_id" {
  type = string
  description = "The Hosted Zone ID where the fastmail records should be added"
}

variable "domain" {
  type = string
  description = "The domain that fastmail DNS records are being applied to"
}
