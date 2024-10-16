module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
  //private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.1.0/24"]
  //public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "ec2" {
  source = "./modules/ec2"

  frontend_subnet_id = module.vpc.public_subnets[0]
  backend_subnet_id = module.vpc.private_subnets[0]
  db_subnet_id  = module.vpc.private_subnets[0]

  vpc_id                  = module.vpc.vpc_id
  public_subnets_ids      = module.vpc.public_subnets
  private_subnets_ids     = module.vpc.private_subnets
}