# Security Group for Load Balancer
resource "aws_security_group" "alb_sg" {
  name        = "ERI-alb-security-group"
  description = "Allow HTTP and SSH traffic from specific IPs"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["85.169.101.162/32"] # Ynov's public IP
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["85.169.101.162/32"] # Ynov's public IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Auto Scaling Instances
resource "aws_security_group" "asg_sg" {
  name        = "ERI-asg-security-group"
  description = "Allow traffic from ALB and SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["85.169.101.162/32"] # Ynov's public IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
