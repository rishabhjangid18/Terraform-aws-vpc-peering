output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_id" {
  value = aws_subnet.this.id
}

output "default_rt_id" {
  value = aws_vpc.this.default_route_table_id
}
