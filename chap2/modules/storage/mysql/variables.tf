variable "db_username" {
  description = "The username for the MySQL database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the MySQL database"
  type        = string
  sensitive   = true
}

variable "identifier_prefix" {
  description = "Prefix to use to identify the database"
  type = string
}

variable "allocated_storage" {
  description = "Storage to be allocated to the database"
  type = number
  default = 10
}

variable "engine" {
  description = "Database engine to use"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type = string
  default = "8.0"
}

variable "instance_class" {
  description = "Instance class for the database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the database"
  type = string
  default = "mydb"
}