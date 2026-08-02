environment          = "prod"
instance_type        = "t3.micro" #Just to keep this within the free tier for now, but we can change this later if we need to a real instance type for production.
vpc_cidr             = "10.1.0.0/16"
public_subnet_a_cidr = "10.1.1.0/24"
public_subnet_b_cidr = "10.1.2.0/24"
allowed_ssh_cidr = "102.135.10.0/24" # VPN CIDR range to restrict access to the production environment. This is the CIDR range of the VPN that we will use to access the production environment.