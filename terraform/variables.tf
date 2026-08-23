variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "us-east-1"
}

variable "environment_prefix" {
  description = "Prefix used for naming resources"
  type        = string
  default     = "placement-portal"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name for EC2 instances"
  type        = string
  default     = "devops-key"
}
