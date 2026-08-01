variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for deployment"
}

variable "app_name" {
  type        = string
  default     = "rewards-app"
  description = "Application name prefix"
}

variable "environment" {
  type        = string
  description = "Target deployment environment (dev or prod)"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "owner" {
  type        = string
  default     = "kerman"
  description = "Resource owner tag"
}

variable "service" {
  type        = string
  default     = "rewards"
  description = "Service name tag"
}

variable "cost_center" {
  type        = string
  default     = "payments"
  description = "Cost center tag for billing allocation"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance size for the environment"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block range for the VPC"
}

variable "public_subnet_a_cidr" {
  type        = string
  description = "CIDR block for Public Subnet A"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "CIDR block for Public Subnet B"
}

variable "aws_account_id" {
  type        = string
  description = "Target AWS Account ID for the environment"
}