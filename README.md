🛠️ Prerequisites & Local Setup 
To run and validate this project locally, ensure you have the following installed:
Terraform (>= 1.5.0)TFLint (>= v0.50.0)
AWS CLI (configured with appropriate IAM permissions)🚀 Running Locally1. 
Initialize and Validate Infrastructure
Navigate to the infra/ directory:Bashcd infra
Initialize Terraform plugins (without remote state for syntax checks):Bashterraform init -backend=false
Run formatting checks and linting:Bash# Auto-format HCL files
terraform fmt -recursive

# Run TFLint against environment variable files
tflint --init
tflint --filter=dev.tfvars --var-file=dev.tfvars
Validate HCL syntax:Bashterraform validate
2. Plan and Deploy (AWS Account Required)Configure your AWS environment credentials locally:Bashexport AWS_REGION="us-east-1"
export AWS_ACCESS_KEY_ID="<YOUR_ACCESS_KEY>"
export AWS_SECRET_ACCESS_KEY="<YOUR_SECRET_KEY>"
Select the desired workspace and run speculative execution plans:Bash# Development Environment
terraform workspace select dev || terraform workspace new dev
terraform plan -var-file="dev.tfvars"

# Apply changes to Dev
terraform apply -var-file="dev.tfvars" -auto-approve
Bash# Production Environment
terraform workspace select prod || terraform workspace new prod
terraform plan -var-file="prod.tfvars"

# Apply changes to Prod
terraform apply -var-file="prod.tfvars" -auto-approve
🔒 Required GitHub Repository SecretsWhen running via GitHub Actions, set the following secrets under Settings > Secrets and variables > Actions:Secret NameDescriptionAWS_REGIONTarget AWS deployment region (e.g., us-east-1)AWS_ROLE_ARN_DEVIAM Role ARN assumed via OIDC for DevelopmentAWS_ROLE_ARN_PRODIAM Role ARN assumed via OIDC for ProductionDEV_AWS_ACCOUNT_ID12-digit AWS Account ID for DevelopmentPROD_AWS_ACCOUNT_ID12-digit AWS Account ID for Production
