/* variable "bucket" {
  description = "The S3 bucket to use"
  type        = string
  sensitive   = true
} */

variable "test_port" {
  description = "Port to use for testing purposes"
  type        = number
  default     = 12345
}