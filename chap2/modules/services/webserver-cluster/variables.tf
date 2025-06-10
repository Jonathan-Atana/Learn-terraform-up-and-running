variable "cluster_name" {
 description = "The name to use for all the cluster resources"
 type = string
}

# variables for instances
variable "instance_type" {
 description = "The type of EC2 Instances to run (e.g. t2.micro)"
 type = string
 default = "t2.micro"
}

# variables for ASG
variable "min_size" {
 description = "The minimum number of EC2 Instances in the ASG"
 type = number
 default = 1
}

variable "max_size" {
 description = "The maximum number of EC2 Instances in the ASG"
 type = number
 default = 2
}

# variables for security groups
variable "custom_http_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "default_http_port" {
  description = "The port the ALB will use for HTTP requests"
  type        = number
  default     = 80
}

# variable for the aws_ami data source
variable "filter_names" {
  description = "List of names to use for filtering AMIs in the data source block"
  type        = list(string)
  default     = ["amzn2-ami-hvm-*-x86_64-gp2"] # default filter name for Amazon Linux 2 AMI
}

# variables for the terraform_remote_state data source
variable "backend" {
  description = "The backend to use"
  type = string
  default = "s3"
}

variable "config" {
  description = "The configuration associated with the specified backend"
  type = map(string)
}