/**
 * # Description
 *
 * This module is to create an aws iam user
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

module "iam_user" {
  source = "github.com/Jonathan-Atana/terraform-modules/global/iam?ref=v1.1.0"

  user_name = var.user_name
}