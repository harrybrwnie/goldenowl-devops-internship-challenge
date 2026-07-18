resource "aws_cloudwatch_dashboard" "goldenowl" {
  dashboard_name = "goldenowl-ecs-overview"

  dashboard_body = jsonencode({
    start          = "-PT3H"
    periodOverride = "inherit"
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "ECS CPU utilization"
          region = var.aws_region
          period = 60
          stat   = "Average"
          yAxis  = { left = { min = 0, max = 100 } }
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", local.environments.staging.cluster, "ServiceName", local.environments.staging.service, { label = "staging" }],
            ["AWS/ECS", "CPUUtilization", "ClusterName", local.environments.production.cluster, "ServiceName", local.environments.production.service, { label = "production" }],
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "ECS memory utilization"
          region = var.aws_region
          period = 60
          stat   = "Average"
          yAxis  = { left = { min = 0, max = 100 } }
          metrics = [
            ["AWS/ECS", "MemoryUtilization", "ClusterName", local.environments.staging.cluster, "ServiceName", local.environments.staging.service, { label = "staging" }],
            ["AWS/ECS", "MemoryUtilization", "ClusterName", local.environments.production.cluster, "ServiceName", local.environments.production.service, { label = "production" }],
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 8
        height = 6
        properties = {
          title  = "Running ECS tasks"
          region = var.aws_region
          period = 60
          stat   = "Average"
          metrics = [
            ["ECS/ContainerInsights", "RunningTaskCount", "ClusterName", local.environments.staging.cluster, "ServiceName", local.environments.staging.service, { label = "staging" }],
            ["ECS/ContainerInsights", "RunningTaskCount", "ClusterName", local.environments.production.cluster, "ServiceName", local.environments.production.service, { label = "production" }],
          ]
        }
      },
      {
        type   = "metric"
        x      = 8
        y      = 6
        width  = 8
        height = 6
        properties = {
          title  = "ALB requests"
          region = var.aws_region
          period = 60
          stat   = "Sum"
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", data.aws_lb.environment["staging"].arn_suffix, { label = "staging" }],
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", data.aws_lb.environment["production"].arn_suffix, { label = "production" }],
          ]
        }
      },
      {
        type   = "metric"
        x      = 16
        y      = 6
        width  = 8
        height = 6
        properties = {
          title  = "ALB target response time"
          region = var.aws_region
          period = 60
          stat   = "Average"
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", data.aws_lb.environment["staging"].arn_suffix, { label = "staging" }],
            ["AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", data.aws_lb.environment["production"].arn_suffix, { label = "production" }],
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6
        properties = {
          title  = "ALB 5XX responses"
          region = var.aws_region
          period = 60
          stat   = "Sum"
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_ELB_5XX_Count", "LoadBalancer", data.aws_lb.environment["staging"].arn_suffix, { label = "staging" }],
            ["AWS/ApplicationELB", "HTTPCode_ELB_5XX_Count", "LoadBalancer", data.aws_lb.environment["production"].arn_suffix, { label = "production" }],
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 12
        width  = 12
        height = 6
        properties = {
          title  = "ALB target health"
          region = var.aws_region
          period = 60
          stat   = "Average"
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", data.aws_lb_target_group.environment["staging"].arn_suffix, "LoadBalancer", data.aws_lb.environment["staging"].arn_suffix, { label = "staging healthy" }],
            ["AWS/ApplicationELB", "UnHealthyHostCount", "TargetGroup", data.aws_lb_target_group.environment["staging"].arn_suffix, "LoadBalancer", data.aws_lb.environment["staging"].arn_suffix, { label = "staging unhealthy" }],
            ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", data.aws_lb_target_group.environment["production"].arn_suffix, "LoadBalancer", data.aws_lb.environment["production"].arn_suffix, { label = "production healthy" }],
            ["AWS/ApplicationELB", "UnHealthyHostCount", "TargetGroup", data.aws_lb_target_group.environment["production"].arn_suffix, "LoadBalancer", data.aws_lb.environment["production"].arn_suffix, { label = "production unhealthy" }],
          ]
        }
      },
    ]
  })
}
