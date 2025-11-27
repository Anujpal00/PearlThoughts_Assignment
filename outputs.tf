output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = module.ec2.public_ip
}

output "strapi_url" {
  description = "Strapi URL (HTTP)"
  value       = "http://${module.ec2.public_ip}:1337"
}
