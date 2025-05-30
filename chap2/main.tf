# Terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.0"
    }
  }
}

#  AWS provider block
provider "aws" {
  region = "us-east-1"
}

locals {
  user_data = <<-EOF
              #!/bin/bash
              sudo yum install busybox httpd -y
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_http_port} &
              EOF
}

# Create a launch template for an ASG
resource "aws_launch_template" "main" {
  name = "my-launch-template"

  image_id               = data.aws_ami.main.id # Amazon Linux 2 AMI
  vpc_security_group_ids = [aws_security_group.ec2.id]
  instance_type          = "t2.micro"

  user_data = base64encode(local.user_data)

  # Required when using a launch configuration with an ASG
  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group (ASG) using the launch configuration
resource "aws_autoscaling_group" "main" {
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest" # Use the latest version of the launch template
  }

  vpc_zone_identifier = data.aws_subnets.default.ids
  target_group_arns   = [aws_lb_target_group.main.arn] # Links the ASG to the target group
  health_check_type   = "ELB"

  min_size = 1
  max_size = 3

  tag {
    key                 = "Name"
    value               = "terraform-aws-asg"
    propagate_at_launch = true
  }
}