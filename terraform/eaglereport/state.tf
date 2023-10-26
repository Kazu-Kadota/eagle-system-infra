data "aws_region" "current" {}

data "terraform_remote_state" "eagleauth" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    key     = "terraform/eagleauth/terraform.tfstate"
    region  = "${module.global_variables.state_region}"
    bucket  = "${module.global_variables.state_bucket}"
    profile = "${module.global_variables.aws_profile}"
  }
}

data "terraform_remote_state" "acm" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    key     = "acm/terraform.tfstate"
    region  = module.global_variables.state_region
    bucket  = module.global_variables.state_bucket
    profile = module.global_variables.aws_profile
  }
}

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/auth-key/ecdsa/private' --type "SecureString" --value "$(cat ecdsa-p256-private.pem)"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/auth-key/ecdsa/private' --type "SecureString" --value "$(cat ecdsa-p256-private.pem)"

# openssl ecparam -genkey -name prime256v1 -noout -out ecdsa-p256-private.pem
# openssl ec -in ecdsa-p256-private.pem -pubout -out ecdsa-p256-public.pem

data "aws_ssm_parameter" "auth_ecdsa_private_key" {
  name = "/${terraform.workspace}/auth-key/ecdsa/private"
}

data "terraform_remote_state" "eaglerequest" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    key     = "terraform/eaglerequest/terraform.tfstate"
    region  = "${module.global_variables.state_region}"
    bucket  = "${module.global_variables.state_bucket}"
    profile = "${module.global_variables.aws_profile}"
  }
}
