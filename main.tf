# 1. Module for backend
module "backend" {
  source       = "./modules/backend"
  project_name = "serverless_container_deployment"
}

# 2. Module for ECR
module "ecr" {
  source       = "./modules/ecr"
  project_name = "serverless_container_deployment"
}

# 3. Module for networking
module "networking" {
  source               = "./modules/networking"
  project_name         = "serverless_container_deployment"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

# 4. Module for security
module "security" {
  source       = "./modules/security"
  project_name = "serverless_container_deployment"
  vpc_id       = module.networking.vpc_id
}
