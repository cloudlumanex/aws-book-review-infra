terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-bookreview"  # Change this
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"                   # Change this
    encrypt        = true
    dynamodb_table = "terraform-state-lock"        # Optional: for state locking
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"

  project_name          = var.project_name
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  aws_region            = var.aws_region
}

module "compute" {
  source = "../../modules/compute"

  project_name        = var.project_name
  environment         = var.environment
  instance_type       = var.instance_type
  ssh_public_key_path = var.ssh_public_key_path
  public_subnet_1_id  = module.network.public_subnet_1_id
  public_subnet_2_id  = module.network.public_subnet_2_id
  frontend_sg_id      = module.network.frontend_sg_id
  backend_sg_id       = module.network.backend_sg_id

  depends_on = [module.network]
}

module "database" {
  source = "../../modules/database"

  project_name        = var.project_name
  environment         = var.environment
  db_instance_class   = var.db_instance_class
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  private_subnet_1_id = module.network.private_subnet_1_id
  private_subnet_2_id = module.network.private_subnet_2_id
  database_sg_id      = module.network.database_sg_id

  depends_on = [module.network]
}