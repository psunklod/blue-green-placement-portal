output "alb_dns_name" {
  description = "Public URL (DNS) of the Application Load Balancer"
  value       = aws_lb.placement_alb.dns_name
}

output "blue_ec2_public_ip" {
  description = "Public IP address of the Blue EC2 instance"
  value       = aws_instance.blue_ec2.public_ip
}

output "green_ec2_public_ip" {
  description = "Public IP address of the Green EC2 instance"
  value       = aws_instance.green_ec2.public_ip
}

output "blue_target_group_arn" {
  description = "ARN of Blue Target Group"
  value       = aws_lb_target_group.blue_tg.arn
}

output "green_target_group_arn" {
  description = "ARN of Green Target Group"
  value       = aws_lb_target_group.green_tg.arn
}

output "alb_listener_arn" {
  description = "ARN of ALB HTTP Listener"
  value       = aws_lb_listener.http_listener.arn
}
