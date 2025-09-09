variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "subnet_id" { type = string }
variable "sg_ids" { type = list(string) }
variable "key_name" { type = string }
variable "associate_public_ip" { type = bool }
variable "ec2_name" { type = string }
