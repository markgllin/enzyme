resource "aws_ecs_cluster_capacity_providers" "ecs_fargate_cp" {
  cluster_name       = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = ["FARGATE_SPOT"]
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.cluster_name}-${var.environment}"
}

data "template_file" "td_template" {
  template = file("./templates/task_definition.json.tpl")
  vars = {
    container_name = var.container_name
    image          = aws_ecr_repository.enzyme.repository_url
    container_port = var.container_port
  }
}

resource "aws_ecs_task_definition" "ecs_td" {
  family                = "${var.cluster_name}-${var.container_name}-td"
  container_definitions = data.template_file.td_template.rendered
  execution_role_arn    = aws_iam_role.ecs_task_exec_role.arn

  cpu          = "256"
  memory       = "512"
  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
  }
}

resource "aws_ecs_service" "ecs_svc" {
  name            = "${var.cluster_name}-${var.container_name}-svc"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_td.arn
  desired_count   = var.desired_ecs_svc_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [ aws_subnet.subnet1.id, aws_subnet.subnet2.id ]
    security_groups  = [ aws_security_group.ecs_svc_sg.id ]
    assign_public_ip = true
  }

  load_balancer {
    container_name   = var.container_name
    container_port   = var.container_port
    target_group_arn = aws_lb_target_group.ecs_lb_tg.arn
  }
}