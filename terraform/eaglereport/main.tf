module "global_variables" {
  source = "../modules/global_variables"
}

provider "aws" {
  profile = module.global_variables.aws_profile
  region  = module.global_variables.aws_region
}

terraform {

  backend "s3" {
    key = "terraform/eaglereport/terraform.tfstate"
  }
}
