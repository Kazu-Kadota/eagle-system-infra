resource "aws_ses_configuration_set" "eaglesystem" {
  name = "eaglesystem-ses-configuration"
}

resource "aws_ses_email_identity" "eaglesystem" {
  email = local.email_name
}

resource "aws_ses_domain_identity" "eaglesystem" {
  domain = local.email_domain_name
}

resource "aws_ses_domain_mail_from" "eaglesystem" {
  domain           = aws_ses_domain_identity.eaglesystem.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.eaglesystem.domain}"
}

resource "aws_ses_domain_dkim" "eaglesystem" {
  domain = aws_ses_domain_identity.eaglesystem.domain
}

resource "aws_route53_record" "eaglesystem_amazonses_dkim_record" {
  count   = 3
  zone_id = data.aws_route53_zone.eaglesystem.id
  name    = "${aws_ses_domain_dkim.eaglesystem.dkim_tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${aws_ses_domain_dkim.eaglesystem.dkim_tokens[count.index]}.dkim.amazonses.com"]
}

resource "aws_route53_record" "eaglesystem_mx" {
  zone_id = data.aws_route53_zone.eaglesystem.id
  name    = aws_ses_domain_mail_from.eaglesystem.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.us-east-1.amazonses.com"] # Change to the region in which `aws_ses_domain_identity.example` is created
}

resource "aws_route53_record" "eaglesystem_txt" {
  zone_id = data.aws_route53_zone.eaglesystem.id
  name    = aws_ses_domain_mail_from.eaglesystem.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

resource "aws_ses_domain_identity_verification" "eaglesystem_verification" {
  domain = aws_ses_domain_identity.eaglesystem.id

  depends_on = [aws_route53_record.eaglesystem_mx]
}