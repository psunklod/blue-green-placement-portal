# Security Group for Load Balancer (Public Traffic)
resource "aws_security_group" "alb_sg" {
  name        = "${var.environment_prefix}-alb-sg"
  description = "Security Group for Application Load Balancer"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "Allow inbound HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_prefix}-alb-sg"
  }
}

# Security Group for EC2 Web Instances (Blue & Green)
resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment_prefix}-ec2-sg"
  description = "Security Group for Blue and Green EC2 Instances"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description     = "Allow HTTP traffic from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description = "Allow SSH management"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment_prefix}-ec2-sg"
  }
}
