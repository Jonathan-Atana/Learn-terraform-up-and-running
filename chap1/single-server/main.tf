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
  instance_type = "t2.micro"
  ami = "ami-02f624c08a83ca16f" # Amazon Linux 2 AMI

  tags = {
    Name = "terraform-example"
  }
}