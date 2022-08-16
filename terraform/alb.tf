resource "aws_lb" "ecs_lb" {
  name            = "${local.resource_prefix}-lb"
  internal        = false
  subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "ecs_lb_tg" {
  name     = "${local.resource_prefix}-lb-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.ecs_vpc.id
}