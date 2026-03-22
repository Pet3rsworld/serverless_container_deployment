variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "alb_sg_id" {
  type        = string
  description = "ID of the ALB"
}

variable "ecs_sg_id" {
  type        = string
  description = "ID of the ECS"
}

variable "container_image" {
  type        = string
  description = "ECR URL of the Docker image to deploy"
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the execution role"
}
