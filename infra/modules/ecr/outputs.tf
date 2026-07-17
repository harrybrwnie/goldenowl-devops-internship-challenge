output "repository_name" {
  description = "Name of the ECR repository."
  value       = aws_ecr_repository.this.name
}

output "repository_arn" {
  description = "ARN of the ECR repository."
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "URL used to tag, push, and deploy container images."
  value       = aws_ecr_repository.this.repository_url
}

output "registry_id" {
  description = "Registry ID that owns the ECR repository."
  value       = aws_ecr_repository.this.registry_id
}
