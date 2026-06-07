module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

  availability_zone = var.availability_zone

  common_tags = local.common_tags
}
module "security_group" {
  source = "../../modules/security-group"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  allowed_ssh_cidr = var.allowed_ssh_cidr

  common_tags = local.common_tags
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment

  common_tags = local.common_tags
}
module "ec2" {
  source = "../../modules/ec2"

  ami                   = var.ami
  instance_type         = var.instance_type
  subnet_id             = module.vpc.public_subnet_id
  security_group_id     = module.security_group.security_group_id
  key_name              = var.key_name
  instance_profile_name = module.iam.instance_profile_name

  project_name = var.project_name
  environment  = var.environment
  common_tags  = local.common_tags
}

module "s3" {
  source = "../../modules/s3"

  project_name = var.project_name
  environment  = var.environment

  bucket_name = var.bucket_name

  common_tags = local.common_tags
}