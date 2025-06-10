# Data sources
data "aws_vpc" "default" { # Get the default VPC in the region
  default = true
}

data "aws_subnets" "default" { # Get the default subnets in the default VPC
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "main" { # get the latest specified ami
  most_recent = true
  owners      = ["amazon"] # Amazon's official AMIs

  filter {
    name   = "name"
    values = var.filter_names
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "terraform_remote_state" "mysql" { # Get the MySQL database state
  backend = var.backend

  config = var.config
}