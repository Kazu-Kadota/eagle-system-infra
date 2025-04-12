default: sdx

preprd: apply
sdx: apply
prd: apply

apply:
	terraform init -reconfigure -backend-config=../$(MAKECMDGOALS).tfbackend
	terraform workspace select $(MAKECMDGOALS) || terraform workspace new $(MAKECMDGOALS)
	terraform apply
