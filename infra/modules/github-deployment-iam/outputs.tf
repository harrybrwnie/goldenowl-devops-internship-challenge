output "staging_role_arn" {
  description = "ARN assumed by the staging GitHub Actions deployment."
  value       = aws_iam_role.deployment["staging"].arn
}

output "production_role_arn" {
  description = "ARN assumed by the production GitHub Actions deployment."
  value       = aws_iam_role.deployment["production"].arn
}

output "role_names" {
  description = "Deployment role names keyed by environment."
  value       = { for environment, role in aws_iam_role.deployment : environment => role.name }
}
