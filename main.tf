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
