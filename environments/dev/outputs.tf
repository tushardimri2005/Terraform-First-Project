output "instance_id" {
  value = module.ec2.instance_id
}
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cidr_block_vpc" {
  value = module.vpc.cidr_block_vpc
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}
