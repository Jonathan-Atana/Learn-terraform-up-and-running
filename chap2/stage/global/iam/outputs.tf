output "iam-user-arn" {
  description = "The ARN of the created user"
  value = module.iam_user.iam-user-arn
}