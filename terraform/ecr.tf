resource "aws_ecr_repository" "enzyme" {
  name = var.container_name
}