/**
 * # Description
 *
 * This module is designed to create a cluster of web server (2) using an Auto Scalling Group (ASG), which serve as target groups to a load balancer.
 * - The web servers accept inbound traffic only from the ALB's security group, and can route traffic to anywhere.
 * - The ALB allows incomming traffic on ports 80, 443 (HTTP and HTTPS), and 12345 (for testing) from anywhere, and routes it to the web servers.
 *
 * ## Usage
 *
 * To use this configuration, ensure you have the necessary AWS credentials set up and run:
 *
 * ```bash
 * terraform init
 * terraform plan
 * terraform apply
 * ```
 *
 * ---
 *
 */

# Terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "github.com/Jonathan-Atana/terraform-modules/services/webserver-cluster?ref=v1.0.0"

  cluster_name = "stage-webservers"
  min_size     = 2
  max_size     = 2

  backend = "local"
  config = {
    path = "../../storage/mysql/terraform.tfstate"
  }
}

# another sec group inbound rule for testing only
resource "aws_vpc_security_group_ingress_rule" "allow_testing" {
  description       = "This Inbound security group is solely for testing purposes (staging)"
  security_group_id = module.webserver_cluster.alb-sec-group-id

  from_port   = var.test_port
  to_port     = var.test_port
  ip_protocol = local.tcp_protocol
  cidr_ipv4   = local.any_ips
}