module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
}

module "internet_gateway" {
  source = "./modules/internet-gateway"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source           = "./modules/route-table"
  vpc_id           = module.vpc.vpc_id
  gateway_id       = module.internet_gateway.igw_id
  public_subnet_id = module.subnet.public_subnet_id
}

module "iam" {
  source = "./modules/iam"
}

module "ec2" {
  source = "./modules/ec2"
}
module "s3" {
  source = "./modules/s3"
}
