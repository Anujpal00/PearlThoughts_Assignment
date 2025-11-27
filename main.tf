module "vpc" {
  source = "./modules/vpc"

  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "ec2" {
  source = "./modules/ec2"

  project_name  = var.project_name
  subnet_id     = module.vpc.public_subnet_id
  vpc_id        = module.vpc.vpc_id
  key_name      = var.key_name
  public_sg_id  = module.vpc.public_sg_id
  instance_type = var.instance_type

  
  user_data = file("${path.module}/user_data.sh")
}
