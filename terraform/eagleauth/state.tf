data "aws_region" "current" {}

# AWS_PROFILE=eagle-back aws ssm put-parameter --region=us-east-1 --name '/sdx/auth-key/ecdsa/private' --type "SecureString" --value "$(cat ecdsa-p256-private.pem)"
# AWS_PROFILE=eagle-back aws ssm put-parameter --region=us-east-1 --name '/prd/auth-key/ecdsa/private' --type "SecureString" --value "$(cat ecdsa-p256-private.pem)"

# openssl ecparam -genkey -name prime256v1 -noout -out ecdsa-p256-private.pem
# openssl ec -in ecdsa-p256-private.pem -pubout -out ecdsa-p256-public.pem

data "aws_ssm_parameter" "auth_ecdsa_private_key" {
  name = "/${terraform.workspace}/auth-key/ecdsa/private"
}