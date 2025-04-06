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

# AWS EC2 instance resource block
resource "aws_instance" "my_instance" {
  instance_type          = "t2.micro"
  ami                    = "ami-02f624c08a83ca16f" # Amazon Linux 2 AMI
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install busybox httpd -y
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_http_port} &
              EOF

  user_data_replace_on_change = true  # Recreate the instance if user_data changes
  tags = {
    Name = "terraform-example"
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

# Define output variables
output "public_ip" {
  description = "The public IP address of the web server"
  value       = aws_instance.my_instance.public_ip
}