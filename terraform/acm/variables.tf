variable "certificate" {
  type = map(any)

  default = {
    sdx    = "sdx.eaglesystem.com.br"
    prd    = "eaglesystem.com.br"
  }
}

variable "alternative_names" {
  default = {
    sdx = [
      "*.sdx.eaglesystem.com.br",
      "*.api.sdx.eaglesystem.com.br",
    ]
    prd = [
      "*.eaglesystem.com.br",
      "*.api.eaglesystem.com.br",
    ]
  }
}

locals {
  certificate       = lookup(var.certificate, terraform.workspace, "sdx")
  alternative_names = lookup(var.alternative_names, terraform.workspace, "sdx")
}
