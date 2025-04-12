variable "project" {
  default = "vpc"
}

variable "cidr_map" {
  type = map(string)

  default = {
    sdx    = "10.0.0.0/16"
    prd    = "10.0.0.0/16"
  }
}

variable "availability_zones" {
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]
}

locals {
  cidr_block = lookup(var.cidr_map, terraform.workspace, "sdx")
}

variable "subnet_size" {
  description = "Subnet size"
  default     = 8
}
