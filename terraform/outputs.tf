output "ecr_repo_url" {
    value = aws_ecr_repository.enzyme.repository_url
}

output "instance_ip_addr" {
  value = aws_lb.ecs_lb.dns_name
}