output "db-address" {
  description = "Connect to the MySQL database at this endpoint"
  value       = aws_db_instance.main.address
}

output "db-port" {
  description = "The port on which the MySQL database is listening/accessible"
  value       = aws_db_instance.main.port
}