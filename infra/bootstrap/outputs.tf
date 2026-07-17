output "state_bucket_name" {
  description = "Name of the S3 bucket used by Terraform backends."
  value       = aws_s3_bucket.terraform_state.id
}

output "state_bucket_arn" {
  description = "ARN of the S3 bucket used by Terraform backends."
  value       = aws_s3_bucket.terraform_state.arn
}

output "backend_region" {
  description = "AWS Region to put in backend configuration files."
  value       = var.aws_region
}
