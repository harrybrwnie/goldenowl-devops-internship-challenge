output "cluster_name" { value = aws_ecs_cluster.this.name }
output "service_name" { value = aws_ecs_service.app.name }
output "task_definition_family" { value = aws_ecs_task_definition.app.family }
output "alb_dns_name" { value = aws_lb.this.dns_name }
output "alb_arn" { value = aws_lb.this.arn }
output "target_group_arn" { value = aws_lb_target_group.app.arn }
output "log_group_name" { value = aws_cloudwatch_log_group.app.name }
