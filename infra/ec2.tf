# -----------------------------------------------------------------------------
# Data Source: Fetch Latest Ubuntu 24.04 LTS AMI (Free Tier Eligible)
# -----------------------------------------------------------------------------
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical Official ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"] # EDIT: Exact 64-bit x86 Ubuntu 24.04 image
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# EC2 Instance Provisioning (Free Tier Compliant)
resource "aws_instance" "compute_node" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type # Default: t3.micro
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.compute_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 15
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  # User Data Script: Non-interactive Ubuntu update + Ansible setup
  user_data = <<-EOF
              #!/bin/bash
              set -e

              export DEBIAN_FRONTEND=noninteractive

              echo "=== Starting APT Package Updates ==="
              apt-get update -y
              apt-get upgrade -y

              echo "=== Installing Dependencies & Ansible via APT ==="
              apt-get install -y \
                software-properties-common \
                curl \
                git \
                python3 \
                python3-pip \
                ansible

              echo "=== Verifying Ansible Installation ==="
              ansible --version
              echo "Free-tier Debian/Ubuntu setup completed!"
              EOF

  tags = {
    Name        = "${var.app_name}-${var.environment}-node"
    Environment = var.environment
    OS          = "Debian-Ubuntu"
    ManagedBy   = "Terraform"
  }
}

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------
output "instance_public_ip" {
  description = "Public IP address of the compute node"
  value       = aws_instance.compute_node.public_ip
}

output "instance_id" {
  description = "AWS EC2 Instance ID"
  value       = aws_instance.compute_node.id
}