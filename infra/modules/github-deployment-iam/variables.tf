variable "oidc_provider_arn" {
  description = "ARN of the existing GitHub Actions OIDC provider."
  type        = string
}

variable "github_subject_prefix" {
  description = "Repository-specific prefix of the GitHub OIDC subject claim."
  type        = string
}

variable "aws_region" {
  description = "AWS Region containing deployment resources."
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID containing deployment resources."
  type        = string
}

variable "aws_partition" {
  description = "AWS partition containing deployment resources."
  type        = string
  default     = "aws"
}

variable "ecr_repository_arn" {
  description = "ARN of the application ECR repository."
  type        = string
}

variable "approved_image_parameter_arn" {
  description = "ARN of the SSM parameter containing the approved image digest."
  type        = string
}
