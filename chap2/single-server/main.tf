# Terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#  AWS provider block
provider "aws" {
  region = "us-east-1"
}

# Create a launch configuration for an ASG
resource "aws_launch_configuration" "my-launch-config" {
  name_prefix     = "terraform-aws-launch-config-"
  image_id        = "ami-02f624c08a83ca16f" # Amazon Linux 2 AMI
  security_groups = [aws_security_group.my-sg.id]
  instance_type   = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install busybox httpd -y
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_http_port} &
              EOF

  # Required when using a launch configuration with an ASG
  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group (ASG) using the launch configuration
resource "aws_autoscaling_group" "my-asg" {
  launch_configuration = aws_launch_configuration.my-launch-config.id
  vpc_zone_identifier  = data.aws_subnets.default-subnets.ids
  min_size             = 1
  max_size             = 2

  tag {
    key                 = "Name"
    value               = "terraform-aws-asg"
    propagate_at_launch = true
  }
}

# Create a security group to allow the EC2 instance (my_instance) to receive
# incomming traffic on port 8080
resource "aws_security_group" "my-sg" {
  name = "terraform-aws-sec-group"

  ingress {
    description = "Allow incomming traffic from port 8080"
    from_port   = var.server_http_port
    to_port     = var.server_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define input variables
variable "server_http_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

# Data sources
data "aws_vpc" "default-vpc" { // Get the default VPC in the region
  default = true
}

data "aws_subnets" "default-subnets" { // Get the default subnets in the default VPC
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default-vpc.id]
  }
}