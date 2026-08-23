# Application Load Balancer
resource "aws_lb" "placement_alb" {
  name               = "${var.environment_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.default.ids

  tags = {
    Name        = "${var.environment_prefix}-alb"
    Environment = "Production"
  }
}

# Blue Target Group
resource "aws_lb_target_group" "blue_tg" {
  name        = "${var.environment_prefix}-tg-blue"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_default_vpc.default.id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.environment_prefix}-tg-blue"
    Color = "blue"
  }
}

# Green Target Group
resource "aws_lb_target_group" "green_tg" {
  name        = "${var.environment_prefix}-tg-green"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_default_vpc.default.id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.environment_prefix}-tg-green"
    Color = "green"
  }
}

# HTTP Listener (Initially forwards to Blue Target Group)
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.placement_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue_tg.arn
  }
}
