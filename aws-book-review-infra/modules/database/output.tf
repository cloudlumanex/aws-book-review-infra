output "mysql_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "MySQL RDS endpoint"
}

output "mysql_address" {
  value       = aws_db_instance.main.address
  description = "MySQL RDS address"
}