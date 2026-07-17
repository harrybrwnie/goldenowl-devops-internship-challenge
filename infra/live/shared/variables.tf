variable "aws_region" {
  description = "AWS Region for shared infrastructure."
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Owner tag applied to shared resources."
  type        = string
  default     = "harrybrwnie"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block assigned to the shared VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "IPv4 CIDR blocks assigned to the two public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ecr_repository_name" {
  description = "Name of the shared application image repository."
  type        = string
  default     = "goldenowl-app"
}

variable "approved_image_parameter_name" {
  description = "SSM parameter name used to store the staging-approved image digest."
  type        = string
  default     = "/goldenowl/approved-image-digest"

  validation {
    condition     = startswith(var.approved_image_parameter_name, "/")
    error_message = "approved_image_parameter_name must be an absolute SSM parameter path."
  }
}

variable "github_repository_owner" {
  description = "Owner of the GitHub repository allowed to deploy."
  type        = string
  default     = "harrybrwnie"
}

variable "github_repository_name" {
  description = "Name of the GitHub repository allowed to deploy."
  type        = string
  default     = "goldenowl-devops-internship-challenge"
}

variable "github_repository_owner_id" {
  description = "Immutable numeric GitHub repository owner ID used in OIDC subjects."
  type        = string
}

variable "github_repository_id" {
  description = "Immutable numeric GitHub repository ID used in OIDC subjects."
  type        = string
}
