# Terraform block
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.99.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# module to create the webserver-cluster
module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "prod-webservers"

  instance_type = "m4.large"
  min_size = 2
  max_size = 10

  backend = "local"
  config = {
    path = "../../storage/mysql/terraform.tfstate"
  }
}

# resources to scale num of servers up or down according to traffic
resource "aws_autoscaling_schedule" "scale_up" {
  scheduled_action_name = "scale-out-during-business-hours"
  autoscaling_group_name = module.webserver_cluster.asg-name
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"  # scale up at 9 a.m everyday
}

resource "aws_autoscaling_schedule" "scale_down" {
  scheduled_action_name = "scale-in-at-night"
  autoscaling_group_name = module.webserver_cluster.asg-name
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"  # scale up at 5 p.m everyday
}