# Blue EC2 Instance (Runs Version 1.0)
resource "aws_instance" "blue_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name        = "${var.environment_prefix}-ec2-blue"
    Environment = "blue"
    Version     = "1.0"
  }
}

# Attach Blue EC2 to Blue Target Group
resource "aws_lb_target_group_attachment" "blue_attachment" {
  target_group_arn = aws_lb_target_group.blue_tg.arn
  target_id        = aws_instance.blue_ec2.id
  port             = 80
}

# Green EC2 Instance (Runs Version 2.0)
resource "aws_instance" "green_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name        = "${var.environment_prefix}-ec2-green"
    Environment = "green"
    Version     = "2.0"
  }
}

# Attach Green EC2 to Green Target Group
resource "aws_lb_target_group_attachment" "green_attachment" {
  target_group_arn = aws_lb_target_group.green_tg.arn
  target_id        = aws_instance.green_ec2.id
  port             = 80
}
