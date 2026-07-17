variable "aws_region" {
  description = "AWS Region where the Terraform state bucket is created."
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Globally unique name for the Terraform state S3 bucket."
  type        = string

  validation {
    condition     = length(var.state_bucket_name) >= 3 && length(var.state_bucket_name) <= 63
    error_message = "state_bucket_name must contain between 3 and 63 characters."
  }
}

variable "owner" {
  description = "Owner tag applied to bootstrap resources."
  type        = string
  default     = "harrybrwnie"
}

variable "force_destroy" {
  description = "Allow deletion of the state bucket while it contains objects. Keep false outside controlled cleanup."
  type        = bool
  default     = false
}
