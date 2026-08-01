# ALB Security Group: Accepts public HTTP traffic
resource "aws_security_group" "alb_sg" {
  name        = "${var.app_name}-${var.environment}-alb-sg"
  description = "Allow inbound HTTP traffic to ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Security Group: Accepts HTTP traffic strictly from the ALB
resource "aws_security_group" "ec2_sg" {
  name        = "${var.app_name}-${var.environment}-ec2-sg"
  description = "Allow inbound HTTP strictly from ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}