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

data "terraform_remote_state" "eagleanalysis" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    key     = "terraform/eagleanalysis/terraform.tfstate"
    region  = "${module.global_variables.state_region}"
    bucket  = "${module.global_variables.state_bucket}"
    profile = "${module.global_variables.aws_profile}"
  }
}

data "terraform_remote_state" "eagleuser" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    key     = "terraform/eagleuser/terraform.tfstate"
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

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/techmize/api/v2/data_source/custom_request/endpoint' --type "SecureString" --value "https://techfonts.techmize.com.br/api/v2/data_source/custom_request"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/techmize/api/v2/data_source/custom_request/endpoint' --type "SecureString" --value "https://techfonts.techmize.com.br/api/v2/data_source/custom_request"

data "aws_ssm_parameter" "techmize_api_v2_data_source_custom_request_endpoint" {
  name = "/${terraform.workspace}/techmize/api/v2/data_source/custom_request/endpoint"
}

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/techmize/api/v2/data_source/get_response/endpoint' --type "SecureString" --value "https://techfonts.techmize.com.br/api/v2/data_source/get_response"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/techmize/api/v2/data_source/get_response/endpoint' --type "SecureString" --value "https://techfonts.techmize.com.br/api/v2/data_source/get_response"

data "aws_ssm_parameter" "techmize_api_v2_data_source_get_response_endpoint" {
  name = "/${terraform.workspace}/techmize/api/v2/data_source/get_response/endpoint"
}

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/techmize/api/v2/token' --type "SecureString" --value "662eb747f6001709dc7f98903eb5b130a299986b"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/techmize/api/v2/token' --type "SecureString" --value "662eb747f6001709dc7f98903eb5b130a299986b"

data "aws_ssm_parameter" "techmize_api_v2_token" {
  name = "/${terraform.workspace}/techmize/api/v2/token"
}
