module "vpc" {
  source               = "../../modules/vpc"
  cidr_block_vpc       = var.cidr_block_vpc
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zone    = var.availability_zone
}

module "iam" {
  source = "../../modules/iam"
}

module "ec2" {
  source        = "../../modules/ec2"
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnet_id

  depends_on = [module.vpc]
}

module "s3" {
  source = "../../modules/s3"
}