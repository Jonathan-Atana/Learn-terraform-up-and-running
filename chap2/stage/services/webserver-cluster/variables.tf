# Define input variables
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

variable "filter_names" {
  description = "List of names to use for filtering AMIs in the data source block"
  type        = list(string)
  default     = ["amzn2-ami-hvm-*-x86_64-gp2"] # default filter name for Amazon Linux 2 AMI
}