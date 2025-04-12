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

# Techmize

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

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/techmize/api/new/v1/request/store_request/endpoint' --type "SecureString" --value "https://sistemas.techfonts.com.br/api/v1/request/store_request"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/techmize/api/new/v1/request/store_request/endpoint' --type "SecureString" --value "https://sistemas.techfonts.com.br/api/v1/request/store_request"

data "aws_ssm_parameter" "techmize_api_new_v1_request_store_request_endpoint" {
  name = "/${terraform.workspace}/techmize/api/new/v1/request/store_request/endpoint"
}

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/techmize/api/new/v1/request/get_response/endpoint' --type "SecureString" --value "https://sistemas.techfonts.com.br/api/v1/request/get_response"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/techmize/api/new/v1/request/get_response/endpoint' --type "SecureString" --value "https://sistemas.techfonts.com.br/api/v1/request/get_response"

data "aws_ssm_parameter" "techmize_api_new_v1_request_get_response_endpoint" {
  name = "/${terraform.workspace}/techmize/api/new/v1/request/get_response/endpoint"
}

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/techmize/api/new/v1/token' --type "SecureString" --value "434c9be48dc9fb960fc03b35b833e564f68b0850"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/techmize/api/new/v1/token' --type "SecureString" --value "434c9be48dc9fb960fc03b35b833e564f68b0850"

data "aws_ssm_parameter" "techmize_api_new_v1_token" {
  name = "/${terraform.workspace}/techmize/api/new/v1/token"
}

# Scoreplus

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/scoreplus/aws_account_id' --type "SecureString" --value "011528291947"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/scoreplus/aws_account_id' --type "SecureString" --value "316279706039"

data "aws_ssm_parameter" "scoreplus_aws_account_id" {
  name = "/${terraform.workspace}/scoreplus/aws_account_id"
}

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/scoreplus/event_bus_requestplus_third_party_analysis_answer_consumer' --type "SecureString" --value "requestplus-third-party-analysis-answer-consumer"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/scoreplus/event_bus_requestplus_third_party_analysis_answer_consumer' --type "SecureString" --value "requestplus-third-party-analysis-answer-consumer"

data "aws_ssm_parameter" "scoreplus_event_bus_requestplus_third_party_analysis_answer_consumer" {
  name = "/${terraform.workspace}/scoreplus/event_bus_requestplus_third_party_analysis_answer_consumer"
}

# Amplify

# Set manually from parameter store console because amplify is builded using AWS Interface
# Need to know which is the api_key from console after creating it

data "aws_ssm_parameter" "amplify_api_gateway_api_key_receive_synthesis" {
  name = "/amplify/shared/d32bhwfrldbzw2/receive_synthesis_api_key"
}

# Transsat

# AWS_PROFILE=eagle-back-sdx aws ssm put-parameter --region=us-east-1 --name '/sdx/transsat/api/synthesis_endpoint' --type "SecureString" --value "https://ipa.sistemagr.com.br/ChatNimueService/GetRetornoPromptRdoAsync"
# AWS_PROFILE=eagle-back-prd aws ssm put-parameter --region=us-east-1 --name '/prd/transsat/api/synthesis_endpoint' --type "SecureString" --value "https://ipa.sistemagr.com.br/ChatNimueService/GetRetornoPromptRdoAsync"

data "aws_ssm_parameter" "transsat_api_synthesis_endpoint" {
  name = "/${terraform.workspace}/transsat/api/synthesis_endpoint"
}
