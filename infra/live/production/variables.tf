variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "owner" {
  type    = string
  default = "harrybrwnie"
}

variable "state_bucket_name" { type = string }

variable "container_image" {
  type = string
  validation {
    condition     = can(regex("@sha256:[0-9a-f]{64}$", var.container_image))
    error_message = "container_image must be an immutable image digest reference."
  }
}
