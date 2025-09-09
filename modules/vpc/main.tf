resource "aws_vpc" "this" {
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block = var.vpc_cidr
  tags = { 
    Name = var.vpc_name 
  }
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = var.create_igw
  tags = { 
    Name = var.subnet_name 
  }
}

resource "aws_internet_gateway" "this" {
  count  = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags   = { 
    Name = "${var.vpc_name}-igw" 
  }
}

# Manage the default route table
resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  # Add Internet route only if IGW is created
  dynamic "route" {
    for_each = var.create_igw ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.this[0].id
    }
  }

  tags = {
    Name = "${var.vpc_name}-default-rt"
  }
}
