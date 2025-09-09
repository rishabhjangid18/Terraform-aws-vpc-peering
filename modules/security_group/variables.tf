variable "vpc_id" { type = string }
variable "sg_name" { type = string }
variable "allow_ssh" { type = bool }
variable "allow_icmp" { type = bool }
variable "cidr_blocks" { type = list(string) }
