# Security group to allow EC2 instances to receive
# incomming traffic on port 8080
resource "aws_security_group" "ec2" {
  name = "ec2-sg"

  ingress {
    description = "Allow incomming traffic from port 8080 to the EC2 instances"
    from_port   = var.server_http_port
    to_port     = var.server_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group to allow the ALB to receive incomming traffic on port 80 and
# outgoing traffic to the internet
resource "aws_security_group" "alb" {
  name = "alb-sg"

  # Allow inbound HTTP requests to the ALB
  ingress {
    description = "Allow incomming traffic on port 80 to access the ALB over HTTP"
    from_port   = var.alb_http_port
    to_port     = var.alb_http_port
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
