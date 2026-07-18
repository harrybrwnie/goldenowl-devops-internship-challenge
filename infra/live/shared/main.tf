data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "network" {
  source = "../../modules/network"

  name_prefix         = "goldenowl-shared"
  vpc_cidr            = var.vpc_cidr
  availability_zones  = local.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name               = var.ecr_repository_name
  max_image_count               = 30
  untagged_image_retention_days = 7
  force_delete                  = false
}
