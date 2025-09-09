resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip
  vpc_security_group_ids      = var.sg_ids

  tags = { Name = var.ec2_name }
}
