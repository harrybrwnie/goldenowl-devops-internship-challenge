resource "aws_cloudwatch_metric_alarm" "unhealthy_targets" {
  for_each = local.environments

  alarm_name          = "goldenowl-${each.key}-unhealthy-targets"
  alarm_description   = "One or more ${each.key} ALB targets are unhealthy."
  namespace           = "AWS/ApplicationELB"
  metric_name         = "UnHealthyHostCount"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 0
  evaluation_periods  = 2
  datapoints_to_alarm = 2
  period              = 60
  statistic           = "Average"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = data.aws_lb.environment[each.key].arn_suffix
    TargetGroup  = data.aws_lb_target_group.environment[each.key].arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  for_each = local.environments

  alarm_name          = "goldenowl-${each.key}-alb-5xx"
  alarm_description   = "The ${each.key} ALB returned at least five 5XX responses in five minutes."
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 5
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  period              = 300
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = data.aws_lb.environment[each.key].arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "production_high_cpu" {
  alarm_name          = "goldenowl-production-high-cpu"
  alarm_description   = "Production ECS CPU remained above 80% for 15 minutes."
  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 80
  evaluation_periods  = 3
  datapoints_to_alarm = 3
  period              = 300
  statistic           = "Average"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ClusterName = local.environments.production.cluster
    ServiceName = local.environments.production.service
  }
}
