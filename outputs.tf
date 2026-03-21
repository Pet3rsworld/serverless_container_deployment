output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "ECR URL for pushing Docker images"
}
