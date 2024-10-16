output "frontend_server_private_ip" {
  value = aws_instance.frontend.private_ip
}

output "frontend_server_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_server_private_ip" {
  value = aws_instance.backend.private_ip
}
output "backend_server_public_ip" {
  value = aws_instance.backend.public_ip
}

output "db_server_private_ip" {
  value = aws_instance.db.private_ip
}

output "db_server_public_ip" {
  value = aws_instance.db.public_ip
}