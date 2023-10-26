variable "project" {
  default = "eagleuser"
}

variable "route53_zone_map" {
  type = map(string)

  default = {
    sdx = "sdx.eaglesystem.com.br."
    prd = "eaglesystem.com.br."
  }
}

variable "domain_name_map" {
  type = map(string)

  default = {
    sdx = "user.api.sdx.eaglesystem.com.br"
    prd = "user.api.eaglesystem.com.br"
  }
}

variable "source_email_map" {
  type = map(string)

  default = {
    sdx = "sdx.admin@eaglesystem.com.br"
    prd = "admin@eaglesystem.com.br"
  }
}

variable "host_map" {
  type = map(string)

  default = {
    sdx = "https://user.api.sdx.eaglesystem.com.br"
    prd = "https://user.api.eaglesystem.com.br"
  }
}

variable "url_map" {
  type = map(string)

  default = {
    sdx = "https://www.sdx.eaglesystem.com.br"
    prd = "https://www.eaglesystem.com.br"
  }
}

locals {
  domain_name       = lookup(var.domain_name_map, terraform.workspace, "sdx")
  route53_zone_name = lookup(var.route53_zone_map, terraform.workspace, "sdx")
  source_email_name = lookup(var.source_email_map, terraform.workspace, "sdx")
  host_name         = lookup(var.host_map, terraform.workspace, "sdx")
  url_name          = lookup(var.url_map, terraform.workspace, "sdx")
}
