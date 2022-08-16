locals {
  resource_prefix = aws_ecs_cluster.ecs_cluster.name
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.cluster_name}-${var.environment}"
}

data "template_file" "td_template" {
  template = file("task_definition.json.tpl")
  vars = {
    container_name = var.container_name
    image          = var.image_url
    container_port = var.container_port
  }
}

resource "aws_ecs_task_definition" "ecs_td" {
  family                = "${var.cluster_name}-${var.container_name}-td"
  container_definitions = data.template_file.td_template.rendered
}

resource "aws_ecs_service" "ecs_svc" {
  name            = "${var.cluster_name}-${var.container_name}-svc"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_td.arn
  desired_count   = var.desired_ecs_svc_count
}