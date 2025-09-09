resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.vpc_a_id
  peer_vpc_id = var.vpc_b_id
  auto_accept = true
  tags        = { Name = "vpc-a-to-b-peering" }
}

# Manage default route tables for both VPCs
resource "aws_default_route_table" "vpc_a" {
  default_route_table_id = var.vpc_a_default_rt

  route {
    cidr_block                = var.vpc_b_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  }

  tags = {
    Name = "vpc-a-default-rt"
  }
}

resource "aws_default_route_table" "vpc_b" {
  default_route_table_id = var.vpc_b_default_rt

  route {
    cidr_block                = var.vpc_a_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  }

  tags = {
    Name = "vpc-b-default-rt"
  }
}
