variable "aws_region" {
  type        = string
  default     = "us-east-1" #us-east-1 for Free Tier eligibility
  description = "AWS region for deployment. Must use us-east-1 or eu-west-1 for Free Tier."
}

variable "instance_type" {
  type        = string
  default     = "t3.micro" #  Free Tier eligible instance size
  description = "EC2 instance size"
}

variable "aws_account_id" {
  type        = string
  description = "Target AWS Account ID passed dynamically from GitHub Secrets"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Allowed IPv4 CIDR block for SSH access on port 22"
}

variable "app_name" {
  type        = string
  default     = "health-app"
}

variable "environment" {
  type        = string
  description = "Target environment (dev or prod)"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  type        = string
  default     = "10.0.2.0/24"
}

variable "service" {
  type        = string
  description = "Name of the service or application"
}

variable "owner" {
  type        = string
  description = "Team or individual owner of the infrastructure"
}

variable "cost_center" {
  type        = string
  description = "Cost center tracking code for resource tag allocations"
}