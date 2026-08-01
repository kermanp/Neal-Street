terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # S3 Remote Backend with S3 Native Lockfile Support
  backend "s3" {
    bucket       = "your-manually-created-bucket-name"
    key          = "app-stack/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region

  # Global default tags automatically applied to ALL AWS resources
  default_tags {
    tags = {
      environment = var.environment
      service     = var.service
      owner       = var.owner
      cost_center = var.cost_center
      ManagedBy   = "Terraform"
    }
  }
}

# Safety Check: Ensures the variable file passed matches the active Terraform workspace
resource "null_resource" "workspace_check" {
  lifecycle {
    precondition {
      condition     = var.environment == terraform.workspace
      error_message = "Mismatched Workspace! You passed '${var.environment}.tfvars' but the active workspace is '${terraform.workspace}'."
    }
  }
}