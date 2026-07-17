output "vpc_id" {
  description = "ID of the shared VPC."
  value       = module.network.vpc_id
}

output "vpc_cidr" {
  description = "IPv4 CIDR block of the shared VPC."
  value       = module.network.vpc_cidr
}

output "availability_zones" {
  description = "Availability Zones used by the shared public subnets."
  value       = local.availability_zones
}

output "public_subnet_ids" {
  description = "IDs of the shared public subnets."
  value       = module.network.public_subnet_ids
}

output "public_route_table_id" {
  description = "ID of the shared public route table."
  value       = module.network.public_route_table_id
}
