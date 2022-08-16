[
  {
    "essential": true,
    "memory": 100,
    "name": "${container_name}",
    "cpu": 1,
    "image": "${image}",
    "environment": [],
    "portMappings": [
        {
          "hostPort": ${container_port},
          "containerPort": ${container_port}
        }
    ]
  }
]