output "dashboard_name" {
  value = aws_cloudwatch_dashboard.goldenowl.dashboard_name
}

output "alarm_names" {
  value = concat(
    values(aws_cloudwatch_metric_alarm.unhealthy_targets)[*].alarm_name,
    values(aws_cloudwatch_metric_alarm.alb_5xx)[*].alarm_name,
    [aws_cloudwatch_metric_alarm.production_high_cpu.alarm_name],
  )
}
