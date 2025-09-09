# VPC A
module "vpc_a" {
  source        = "./modules/vpc"
  vpc_cidr      = var.vpc_a_cidr
  subnet_cidr   = var.subnet_a_cidr
  az            = var.az_a
  vpc_name      = "vpc-a-web"
  subnet_name   = "subnet-a-public"
  create_igw    = true
}

# VPC B
module "vpc_b" {
  source        = "./modules/vpc"
  vpc_cidr      = var.vpc_b_cidr
  subnet_cidr   = var.subnet_b_cidr
  az            = var.az_b
  vpc_name      = "vpc-b-app"
  subnet_name   = "subnet-b-private"
  create_igw    = false
}

# VPC Peering
# module "vpc_peering" {
#   source        = "./modules/vpc_peering"
#   vpc_a_id      = module.vpc_a.vpc_id
#   vpc_b_id      = module.vpc_b.vpc_id
#   vpc_a_cidr    = var.vpc_a_cidr
#   vpc_b_cidr    = var.vpc_b_cidr
# }
module "vpc_peering" {
  source            = "./modules/vpc_peering"
  vpc_a_id          = module.vpc_a.vpc_id
  vpc_b_id          = module.vpc_b.vpc_id
  vpc_a_cidr        = var.vpc_a_cidr
  vpc_b_cidr        = var.vpc_b_cidr
  vpc_a_default_rt  = module.vpc_a.default_rt_id
  vpc_b_default_rt  = module.vpc_b.default_rt_id
}

# Security Groups
module "web_sg" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc_a.vpc_id
  sg_name       = "web-sg"
  allow_ssh     = true
  allow_icmp    = false
  cidr_blocks   = ["0.0.0.0/0"]
}

module "app_sg" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc_b.vpc_id
  sg_name       = "app-sg"
  allow_ssh     = true
  allow_icmp    = true
  cidr_blocks   = [var.vpc_a_cidr]
}

# EC2 Instances

resource "aws_key_pair" "this" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub") # Path to your local public key file
}


module "web_ec2" {
  source            = "./modules/ec2"
  subnet_id         = module.vpc_a.subnet_id
  sg_ids            = [module.web_sg.sg_id]
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = aws_key_pair.this.key_name
  associate_public_ip = true
  ec2_name          = "web-ec2"
}

module "app_ec2" {
  source            = "./modules/ec2"
  subnet_id         = module.vpc_b.subnet_id
  sg_ids            = [module.app_sg.sg_id]
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = aws_key_pair.this.key_name
  associate_public_ip = false
  ec2_name          = "app-ec2"
}
