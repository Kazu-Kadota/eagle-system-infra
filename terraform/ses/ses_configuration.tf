resource "aws_ses_configuration_set" "systemeagle" {
  name = "systemeagle-ses-configuration"
}

resource "aws_ses_email_identity" "systemeagle" {
  email = local.email_name
}

resource "aws_ses_domain_identity" "systemeagle" {
  domain = local.email_domain_name
}

resource "aws_ses_domain_mail_from" "systemeagle" {
  domain           = aws_ses_domain_identity.systemeagle.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.systemeagle.domain}"
}

resource "aws_ses_domain_dkim" "systemeagle" {
  domain = aws_ses_domain_identity.systemeagle.domain
}

resource "aws_route53_record" "systemeagle_amazonses_dkim_record" {
  count   = 3
  zone_id = data.aws_route53_zone.systemeagle.id
  name    = "${aws_ses_domain_dkim.systemeagle.dkim_tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${aws_ses_domain_dkim.systemeagle.dkim_tokens[count.index]}.dkim.amazonses.com"]
}

resource "aws_route53_record" "systemeagle_mx" {
  zone_id = data.aws_route53_zone.systemeagle.id
  name    = aws_ses_domain_mail_from.systemeagle.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.us-east-1.amazonses.com"] # Change to the region in which `aws_ses_domain_identity.example` is created
}

resource "aws_route53_record" "systemeagle_txt" {
  zone_id = data.aws_route53_zone.systemeagle.id
  name    = aws_ses_domain_mail_from.systemeagle.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

resource "aws_ses_domain_identity_verification" "systemeagle_verification" {
  domain = aws_ses_domain_identity.systemeagle.id

  depends_on = [aws_route53_record.systemeagle_mx]
}