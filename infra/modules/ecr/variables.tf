variable "repository_name" {
  description = "Name of the ECR repository."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+(?:[._/-][a-z0-9]+)*$", var.repository_name))
    error_message = "repository_name must use lowercase ECR repository name characters."
  }
}

variable "max_image_count" {
  description = "Maximum number of image revisions retained by the lifecycle policy."
  type        = number
  default     = 30

  validation {
    condition     = var.max_image_count >= 1
    error_message = "max_image_count must be at least 1."
  }
}

variable "untagged_image_retention_days" {
  description = "Number of days an untagged image is retained."
  type        = number
  default     = 7

  validation {
    condition     = var.untagged_image_retention_days >= 1
    error_message = "untagged_image_retention_days must be at least 1."
  }
}

variable "force_delete" {
  description = "Allow Terraform to delete the repository while it contains images."
  type        = bool
  default     = false
}
