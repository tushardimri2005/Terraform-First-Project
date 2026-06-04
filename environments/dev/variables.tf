
variable "ami" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "cidr_block_vpc"{
    type  = string
}

variable "public_subnet_cidrs" {
  type = string
}

variable "private_subnet_cidrs" {
  type = string
}
variable "availability_zone" {
  type = string
}

variable "aws_region" {
   type = string
}
