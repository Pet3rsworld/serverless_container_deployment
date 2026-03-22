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

# 5. Module for compute
module "compute" {
  source             = "./modules/compute"
  project_name       = "serverless_container_deployment"
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  alb_sg_id          = module.security.alb_sg_id
  ecs_sg_id          = module.security.ecs_sg_id
  container_image    = "591359167483.dkr.ecr.us-east-1.amazonaws.com/serverless_container_deployment-fintech-repo:latest"
  execution_role_arn = module.security.execution_role_arn
}
