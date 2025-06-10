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

module "mysql" {
  source = "github.com/Jonathan-Atana/terraform-modules/storage/mysql"

  identifier_prefix = "prod-mysql-"

  db_username = var.db_username
  db_password = var.db_password
}