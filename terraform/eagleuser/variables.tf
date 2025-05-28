variable "project" {
  default = "eagleuser"
}

variable "route53_zone_map" {
  type = map(string)

  default = {
    sdx = "sdx.systemeagle.com.br."
    prd = "systemeagle.com.br."
  }
}

variable "domain_name_map" {
  type = map(string)

  default = {
    sdx = "user.api.sdx.systemeagle.com.br"
    prd = "user.api.systemeagle.com.br"
  }
}

variable "source_email_map" {
  type = map(string)

  default = {
    sdx = "admin@systemeagle.com.br"
    prd = "admin@systemeagle.com.br"
  }
}

variable "host_map" {
  type = map(string)

  default = {
    sdx = "https://user.api.sdx.systemeagle.com.br"
    prd = "https://user.api.systemeagle.com.br"
  }
}

variable "url_map" {
  type = map(string)

  default = {
    sdx = "https://sdx.systemeagle.com.br"
    prd = "https://www.systemeagle.com.br"
  }
}

locals {
  domain_name       = lookup(var.domain_name_map, terraform.workspace, "sdx")
  route53_zone_name = lookup(var.route53_zone_map, terraform.workspace, "sdx")
  source_email_name = lookup(var.source_email_map, terraform.workspace, "sdx")
  host_name         = lookup(var.host_map, terraform.workspace, "sdx")
  url_name          = lookup(var.url_map, terraform.workspace, "sdx")
}
