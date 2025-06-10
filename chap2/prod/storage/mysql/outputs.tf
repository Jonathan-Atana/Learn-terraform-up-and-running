output "db-address" {
  description = "Connect to the MySQL database at this endpoint"
  value       = module.mysql.db-address
}

output "db-port" {
  description = "The port on which the MySQL database is listening/accessible"
  value       = module.mysql.db-port
}