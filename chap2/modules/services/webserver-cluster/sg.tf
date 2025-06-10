# Security groups and rules
resource "aws_security_group" "ec2" {
  name        = "${var.cluster_name}-ec2-sg"
  vpc_id      = data.aws_vpc.default.id
  description = "This security group is for the EC2 instances created by the ASG. Port 8080 is opened for both apache and health checks from the ALB"

  ingress { # configure apache's config file to listen on port 8080
    description     = "Allow incomming traffic from this security group on port 8080 to the EC2 instances"
    from_port       = var.custom_http_port
    to_port         = var.custom_http_port
    protocol        = local.tcp_protocol
    security_groups = [aws_security_group.alb.id]
  }

  egress {  # needed for the ec2 instances to install packages
    description = "Allow all outbound traffic from the EC2 instances"
    from_port = local.any_port
    to_port = local.any_port
    protocol = local.any_protocol
    cidr_blocks = [local.any_ips]  # All ips
  }
}

resource "aws_security_group" "alb" {
  name        = "${var.cluster_name}-alb-sg"
  vpc_id      = data.aws_vpc.default.id
  description = "This security group is for the ALB. Port 80 is opened to send/receive traffic from anywhere"
}

# Security group rules
resource "aws_vpc_security_group_ingress_rule" "allow_http" {  # Allow inbound HTTP requests to the ALB
  description = "Allow incomming traffic on port 80 to access the ALB over HTTP"
  security_group_id = aws_security_group.alb.id

  from_port   = var.default_http_port
  to_port     = var.default_http_port
  ip_protocol = local.tcp_protocol
  cidr_ipv4 = local.any_ips
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {  # Allow all outbound requests
  security_group_id = aws_security_group.alb.id

  from_port   = local.any_port
  to_port     = local.any_port
  ip_protocol = local.any_protocol
  cidr_ipv4 = local.any_ips  # All ips
}