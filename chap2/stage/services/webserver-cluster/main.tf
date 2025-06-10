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
  source = "../../../modules/services/webserver-cluster"

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