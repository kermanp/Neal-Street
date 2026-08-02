environment          = "dev"
instance_type        = "t3.micro"
vpc_cidr             = "10.0.0.0/16"
public_subnet_a_cidr = "10.0.1.0/24"
public_subnet_b_cidr = "10.0.2.0/24"
allowed_ssh_cidr = "196.21.0.5/32"  # work network range or laptop IP address