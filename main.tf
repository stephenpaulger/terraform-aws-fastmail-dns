terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.39.0"
    }
  }
}


locals {
  dkim_hosts = [
    "fm1",
    "fm2",
    "fm3",
  ]

  mx_hosts = [
    var.domain,
    "*.${var.domain}",
    "mail.${var.domain}",
  ]
}

resource "aws_route53_record" "mail" {
  zone_id = var.zone_id
  name    = "mail.${var.domain}"
  type    = "A"
  ttl     = "300"

  records = [
    "66.111.4.147",
    "66.111.4.148",
  ]
}

resource "aws_route53_record" "mx" {
  count = length(local.mx_hosts)

  zone_id = var.zone_id
  name    = element(local.mx_hosts, count.index)
  type    = "MX"
  ttl     = "300"

  records = [
    "10 in1-smtp.messagingengine.com",
    "20 in2-smtp.messagingengine.com",
  ]
}

resource "aws_route53_record" "spf" {
  zone_id = var.zone_id
  name    = var.domain
  type    = "TXT"
  ttl     = "300"

  records = [
    "v=spf1 include:spf.messagingengine.com ?all",
  ]
}

resource "aws_route53_record" "dkim" {
  count = length(local.dkim_hosts)

  zone_id = var.zone_id
  name    = "${element(local.dkim_hosts, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${element(local.dkim_hosts, count.index)}.${var.domain}.dkim.fmhosted.com",
  ]
}
