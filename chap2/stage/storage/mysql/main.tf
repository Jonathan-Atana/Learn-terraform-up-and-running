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

# Resource block to create an RDS MySQL instance
resource "aws_db_instance" "main" {
  identifier_prefix   = "mydb-"
  allocated_storage   = 10
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = "mydb"
  skip_final_snapshot = true

  username = var.db_username
  password = var.db_password
}