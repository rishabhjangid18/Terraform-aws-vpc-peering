# VPC Outputs
output "vpc_id_web" {
  value = module.vpc_a.vpc_id
}

output "vpc_subnet_web" {
  value = module.vpc_a.subnet_id
}

output "vpc_id_app" {
  value = module.vpc_b.vpc_id
}

output "vpc_subnet_app" {
  value = module.vpc_b.subnet_id
}

# VPC Peering
output "vpc_peering" {
  value = module.vpc_peering.peering_id
}

# EC2 Outputs
output "ec2_web_publicIP" {
  value = module.web_ec2.public_ip
}

output "ec2_web_privateIp" {
  value = module.web_ec2.private_ip
}

output "ec2_web_dns" {
  value = module.web_ec2.public_dns
}

output "ec2_app_privateIp" {
  value = module.app_ec2.private_ip
}
