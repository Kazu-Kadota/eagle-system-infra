// This only exists because at day 12/03/2025 we tried to create a API Gateway -> ALB -> Lambda architecture and it doesn't work, and I didn't wanted to exclude what I created

module "global_variables" {
  source = "../modules/global_variables"
}

provider "aws" {
  profile = module.global_variables.aws_profile
  region  = module.global_variables.aws_region
}

terraform {

  backend "s3" {
    key = "vpc/terraform.tfstate"
  }
}
