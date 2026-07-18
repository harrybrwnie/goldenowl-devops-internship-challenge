locals {
  environments = {
    staging = {
      cluster = "goldenowl-staging-cluster"
      service = "goldenowl-staging-service"
    }
    production = {
      cluster = "goldenowl-production-cluster"
      service = "goldenowl-production-service"
    }
  }
}

data "aws_lb" "environment" {
  for_each = local.environments
  name     = "goldenowl-${each.key}-alb"
}

data "aws_lb_target_group" "environment" {
  for_each = local.environments
  name     = "goldenowl-${each.key}-tg"
}
