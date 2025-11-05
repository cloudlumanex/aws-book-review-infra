output "frontend_public_ip" {
  value       = module.compute.frontend_public_ip
  description = "Frontend EC2 public IP address"
}

output "backend_public_ip" {
  value       = module.compute.backend_public_ip
  description = "Backend EC2 public IP address"
}

output "mysql_endpoint" {
  value       = module.database.mysql_endpoint
  description = "MySQL RDS endpoint"
}

output "mysql_address" {
  value       = module.database.mysql_address
  description = "MySQL RDS address (without port)"
}

output "vpc_id" {
  value = module.network.vpc_id
}