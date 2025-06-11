/**
 * # Description
 *
 * This Terraform configuration sets up a MySQL database
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

module "mysql" {
  source = "github.com/Jonathan-Atana/terraform-modules/storage/mysql?ref=v1.0.0"

  identifier_prefix = "prod-mysql-"

  db_username = var.db_username
  db_password = var.db_password
}