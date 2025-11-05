output "frontend_public_ip" {
  value       = aws_eip.frontend.public_ip
  description = "Frontend EC2 public IP"
}

output "backend_public_ip" {
  value       = aws_eip.backend.public_ip
  description = "Backend EC2 public IP"
}

output "frontend_instance_id" {
  value = aws_instance.frontend.id
}

output "backend_instance_id" {
  value = aws_instance.backend.id
}