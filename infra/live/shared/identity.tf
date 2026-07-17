data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_iam_openid_connect_provider" "github" {
  arn = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
}

locals {
  github_subject_prefix = "repo:${var.github_repository_owner}@${var.github_repository_owner_id}/${var.github_repository_name}@${var.github_repository_id}"
}

module "github_deployment_iam" {
  source = "../../modules/github-deployment-iam"

  oidc_provider_arn            = data.aws_iam_openid_connect_provider.github.arn
  github_subject_prefix        = local.github_subject_prefix
  aws_region                   = var.aws_region
  aws_account_id               = data.aws_caller_identity.current.account_id
  aws_partition                = data.aws_partition.current.partition
  ecr_repository_arn           = module.ecr.repository_arn
  approved_image_parameter_arn = aws_ssm_parameter.approved_image_digest.arn
}
