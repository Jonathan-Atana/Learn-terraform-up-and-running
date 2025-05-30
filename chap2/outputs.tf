# Define output variables
output "alb-dns-name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.main.dns_name

}