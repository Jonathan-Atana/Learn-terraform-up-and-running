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

# Define input variables
variable "server_http_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "alb_http_port" {
  description = "The port the ALB will use for HTTP requests"
  type        = number
  default     = 80
}

# Define output variables
output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.my-alb.dns_name

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