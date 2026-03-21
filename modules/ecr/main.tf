resource "aws_ecr_repository" "fintech_repo" {
  name                 = "${var.project_name}-fintech-repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
