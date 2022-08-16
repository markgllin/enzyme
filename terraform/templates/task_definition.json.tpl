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
          "hostPort": 8080,
          "containerPort": ${container_port}
        }
    ]
  }
]