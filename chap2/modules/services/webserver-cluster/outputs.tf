# Define output variables
output "alb-dns-name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "asg-name" {
  description = "The name of the ASG"
  value = aws_autoscaling_group.main.name
}

output "alb-sec-group-id" {
  description = "The security group id of the ALB"
  value = aws_security_group.alb.id
}