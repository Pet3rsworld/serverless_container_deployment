output "repository_url" {
  value       = aws_ecr_repository.fintech_repo.repository_url
  description = "URL of the ECR repository"
}
