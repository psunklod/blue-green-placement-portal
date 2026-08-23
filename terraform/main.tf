terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Default VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = "${var.environment_prefix}-vpc"
  }
}

# Fetch default subnets for multi-AZ ALB deployment
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

# Latest Ubuntu 22.04 LTS AMI lookup
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
