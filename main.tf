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
  source     = "./modules/route-table"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.internet_gateway.igw_id
}

module "iam" {
  source = "./modules/iam"
}

module "ec2" {
  source = "./modules/ec2"

  security_group_id = module.security_group.sg_id

  index_html = file("${path.root}/website/index.html")
  style_css  = file("${path.root}/website/style.css")
}
module "s3" {
  source = "./modules/s3"
}
module "security_group" {
  source = "./modules/security-group"
}