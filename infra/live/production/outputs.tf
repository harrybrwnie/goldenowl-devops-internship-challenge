output "cluster_name" { value = module.production.cluster_name }
output "service_name" { value = module.production.service_name }
output "task_definition_family" { value = module.production.task_definition_family }
output "alb_dns_name" { value = module.production.alb_dns_name }
output "alb_url" { value = "http://${module.production.alb_dns_name}" }
output "target_group_arn" { value = module.production.target_group_arn }
output "log_group_name" { value = module.production.log_group_name }
