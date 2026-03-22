# 1. Public facing ALB 
resource "aws_lb" "alb_lb" {
  name               = "container-alb-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids
}

# 2. Target Group for our ALB
resource "aws_lb_target_group" "alb_tg" {
  name        = "container-alb-tg"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

# 3 ALB listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# 4. The logical cluster grouping
resource "aws_ecs_cluster" "grouping_cluster" {
  name = "${var.project_name}-grouping-cluster"
}

# 5. Task definition for ECS
resource "aws_ecs_task_definition" "ecs_td" {
  family                   = "container-ecs-td"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.project_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# 6. Engine that runs our ECS
resource "aws_ecs_service" "ecs_api" {
  name            = "container-ecs-api"
  cluster         = aws_ecs_cluster.grouping_cluster.id
  task_definition = aws_ecs_task_definition.ecs_td.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.public_subnet_ids # To bypass NAT gateway fees
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    container_name   = var.project_name
    container_port   = 5000
  }
}
