# Terraform Fastmail DNS

Add [DNS records suggested by fastmail](https://www.fastmail.help/hc/en-us/articles/360060591153)
in order to:

 * set MX records for your domain and all subdomains,
 * allow web mail to be accessed at mail.yourdomain.com,
 * and add [SPF](https://en.wikipedia.org/wiki/Sender_Policy_Framework) and [DKIM](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail) records to help prevent forged mail from your domain.

At present this module does not add entries for email, CalDAV and CardDAV clients to auto-discover settings.


## Requirements

- Terraform 0.13+
- [aws provider 4.39.0](https://registry.terraform.io/providers/hashicorp/aws/4.39.0/docs)


## Usage

```hcl
resource "aws_route53_zone" "primary" {
  name = var.domain
}

module "fastmail_dns" {
  source  = "stephenpaulger/fastmail-dns/aws"
  version = "2.0.0"

  zone_id = aws_route53_zone.primary.zone_id
  domain  = var.domain
}
```
