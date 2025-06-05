# Security groups
resource "aws_security_group" "ec2" {
  name        = "ec2-sg"
  vpc_id      = data.aws_vpc.default.id
  description = "This security group is for the EC2 instances created by the ASG. Port 8080 is opened for both apache and health checks from the ALB"

  ingress { # configure apache's config file to listen on port 8080
    description     = "Allow incomming traffic from this security group on port 8080 to the EC2 instances"
    from_port       = var.custom_http_port
    to_port         = var.custom_http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
}

resource "aws_security_group" "alb" {
  name        = "alb-sg"
  vpc_id      = data.aws_vpc.default.id
  description = "This security group is for the ALB. Port 80 is opened to send/receive traffic from anywhere"

  # Allow inbound HTTP requests to the ALB
  ingress {
    description = "Allow incomming traffic on port 80 to access the ALB over HTTP"
    from_port   = var.default_http_port
    to_port     = var.default_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}
