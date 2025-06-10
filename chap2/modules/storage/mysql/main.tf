# Resource block to create an RDS MySQL instance
resource "aws_db_instance" "main" {
  identifier_prefix   = var.identifier_prefix
  allocated_storage   = var.allocated_storage
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  db_name             = var.db_name
  skip_final_snapshot = true

  username = var.db_username
  password = var.db_password
}