output "frontend_server_public_ip" {
  value = module.ec2.frontend_server_public_ip
}

output "frontend_server_private_ip" {
  value = module.ec2.frontend_server_private_ip
}

output "backend_server_public_ip" {
  value = module.ec2.backend_server_public_ip
}

output "backend_server_private_ip" {
  value = module.ec2.backend_server_private_ip
}

output "db_server_public_ip" {
  value = module.ec2.db_server_public_ip
}

output "db_server_private_ip" {
  value = module.ec2.db_server_private_ip
}