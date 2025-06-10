# Create an Application Load Balancer (ALB) to route traffic to the EC2 instances
resource "aws_lb" "main" {
  name               = "${var.cluster_name}-alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb.id]
}

# Define a listener for the ALB
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.default_http_port
  protocol          = "HTTP"

  # return a simple 404 page by default
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

# Define the target group for the ALB
resource "aws_lb_target_group" "main" {
  name     = "${var.cluster_name}-alb-tg"
  port     = var.custom_http_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    enabled             = true
    protocol            = "HTTP"
    port                = "traffic-port"
    matcher             = 200
    interval            = 10
    timeout             = 6
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Define the listener rule for the ALB
resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}