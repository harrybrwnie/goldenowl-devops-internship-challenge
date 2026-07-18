data "terraform_remote_state" "shared" {
  backend = "s3"
  config = {
    bucket       = var.state_bucket_name
    key          = "goldenowl/shared/terraform.tfstate"
    region       = var.aws_region
    encrypt      = true
    use_lockfile = true
  }
}

module "production" {
  source = "../../modules/ecs-environment"

  environment        = "production"
  vpc_id             = data.terraform_remote_state.shared.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.shared.outputs.public_subnet_ids
  container_image    = var.container_image
  desired_count      = 2
  min_capacity       = 2
  max_capacity       = 4
  cpu_target         = 60
  log_retention_days = 30
}
