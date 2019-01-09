# Terraform Fastmail DNS

Add [DNS records suggested by fastmail](https://www.fastmail.com/help/receive/domains-advanced.html)
in order to:-

 * set MX records for your domain and all subdomains,
 * allow web mail to be accessed at mail.yourdomain.com,
 * and add [SPF](https://en.wikipedia.org/wiki/Sender_Policy_Framework) and [DKIM](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail) records to help prevent forged mail from your domain.

At present this module does not add entries for email, CalDAV and CardDAV clients to auto-discover settings.

## Usage

```
resource "aws_route53_zone" "primary" {
  name = "${var.domain}"
}

module "fastmail_dns" {
  source  = "stephenpaulger/fastmail-dns/aws"
  version = "1.0.1"

  zone_id = "${aws_route53_zone.primary.zone_id}"
  domain = "${var.domain}"
}
```
