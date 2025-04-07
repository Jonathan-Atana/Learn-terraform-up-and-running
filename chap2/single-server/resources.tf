# Create an Application Load Balancer (ALB) to route traffic to the EC2 instances
resource "aws_lb" "my-alb" {
  name               = "terraform-aws-alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default-subnets.ids
  security_groups    = [aws_security_group.my-alb-sg.id]
}

# Define a listener for the ALB
resource "aws_lb_listener" "my-alb-http-listener" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = var.alb_http_port
  protocol          = "HTTP"

  # return a simple 404 page by default
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page not found"
      status_code  = "404"
    }
  }
}

# Define the target group for the ALB
resource "aws_lb_target_group" "my-alb-target-group" {
  name     = "terraform-aws-alb-target-group"
  port     = var.server_http_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default-vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Define the listener rule for the ALB
resource "aws_lb_listener_rule" "my-alb-listener-rule" {
  listener_arn = aws_lb_listener.my-alb-http-listener.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-alb-target-group.arn
  }
}

# Create a launch configuration for an ASG
resource "aws_launch_configuration" "my-launch-config" {
  name_prefix     = "terraform-aws-launch-config-"
  image_id        = "ami-02f624c08a83ca16f" # Amazon Linux 2 AMI
  security_groups = [aws_security_group.my-sg.id]
  instance_type   = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install busybox httpd -y
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_http_port} &
              EOF

  # Required when using a launch configuration with an ASG
  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group (ASG) using the launch configuration
resource "aws_autoscaling_group" "my-asg" {
  launch_configuration = aws_launch_configuration.my-launch-config.id
  vpc_zone_identifier  = data.aws_subnets.default-subnets.ids

  target_group_arns = [aws_lb_target_group.my-alb-target-group.arn]
  health_check_type = "ELB"

  min_size = 1
  max_size = 2

  tag {
    key                 = "Name"
    value               = "terraform-aws-asg"
    propagate_at_launch = true
  }
}

# Create a security group to allow the EC2 instance (my_instance) to receive
# incomming traffic on port 8080
resource "aws_security_group" "my-sg" {
  name = "terraform-aws-sec-group"

  ingress {
    description = "Allow incomming traffic from port 8080"
    from_port   = var.server_http_port
    to_port     = var.server_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my-alb-sg" {
  name = "terraform-aws-alb-sec-group"

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