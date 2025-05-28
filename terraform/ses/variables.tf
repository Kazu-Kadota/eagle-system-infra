variable "project" {
  default = "ses"
}

variable "route53_zone_map" {
  type = map(string)

  default = {
    sdx = "sdx.systemeagle.com.br."
    prd = "systemeagle.com.br."
  }
}

variable "email_name_map" {
  type = map(string)

  default = {
    sdx = "admin@systemeagle.com.br"
    prd = "admin@systemeagle.com.br"
  }
}

variable "email_domain_name_map" {
  type = map(string)

  default = {
    sdx = "sdx.systemeagle.com.br"
    prd = "systemeagle.com.br"
  }
}

locals {
  email_domain_name = lookup(var.email_domain_name_map, terraform.workspace, "sdx")
  route53_zone_name = lookup(var.route53_zone_map, terraform.workspace, "sdx")
  email_name        = lookup(var.email_name_map, terraform.workspace, "sdx")
}
