########## ECS_LB
resource "aws_security_group" "ecs_lb_sg" {
  name   = "${local.resource_prefix}-lb-sg"
  vpc_id = aws_vpc.ecs_vpc.id
}

resource "aws_security_group_rule" "allow_lb_port_443_ingress" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ecs_lb_sg.id
}

resource "aws_security_group_rule" "allow_lb_all_egress" {
  security_group_id = aws_security_group.ecs_lb_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

########## ECS Service
resource "aws_security_group" "ecs_svc_sg" {
  name   = "${local.resource_prefix}-svc-sg"
  vpc_id = aws_vpc.ecs_vpc.id
}

resource "aws_security_group_rule" "allow_svc_port_ingress" {
  security_group_id = aws_security_group.ecs_svc_sg.id

  type        = "ingress"
  from_port   = var.container_port
  to_port     = var.container_port
  protocol    = "tcp"

  source_security_group_id = aws_security_group.ecs_lb_sg.id
}

resource "aws_security_group_rule" "allow_svc_all_egress" {
  security_group_id = aws_security_group.ecs_svc_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
