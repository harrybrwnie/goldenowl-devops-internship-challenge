output "cluster_name" { value = module.staging.cluster_name }
output "service_name" { value = module.staging.service_name }
output "task_definition_family" { value = module.staging.task_definition_family }
output "alb_dns_name" { value = module.staging.alb_dns_name }
output "alb_url" { value = "http://${module.staging.alb_dns_name}" }
output "target_group_arn" { value = module.staging.target_group_arn }
output "log_group_name" { value = module.staging.log_group_name }
