output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "ECR URL for pushing Docker images"
}

output "alb_public_url" {
  value       = "http://${module.compute.alb_dns_name}"
  description = "Public URL of the fintech API"
}
