resource "aws_security_group" "this" {
  name        = var.sg_name
  vpc_id      = var.vpc_id
  description = "Managed by Terraform"

  dynamic "ingress" {
    for_each = var.allow_ssh ? [1] : []
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = var.allow_icmp ? [1] : []
    content {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = var.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
