resource "aws_ssm_parameter" "approved_image_digest" {
  name        = var.approved_image_parameter_name
  description = "Staging-approved ECR image digest promoted to production."
  type        = "String"
  tier        = "Standard"
  data_type   = "text"
  value       = "UNSET"

  lifecycle {
    ignore_changes = [value]
  }
}
