# Enzyme

A small Sinatra application used to display spec results & demonstrate loadbalancing.

[`/enzyme/lib/`](https://github.com/markgllin/enzyme/tree/main/lib) contains the implementation for [CRAQ Question Validation](https://gist.github.com/juggy/170ececa9a3b0b2162e49bc2e082179e)

[`/enzyme/spec/`](https://github.com/markgllin/enzyme/tree/main/spec) are the accompanying unit tests.

[`/enzyme/terraform/`](https://github.com/markgllin/enzyme/tree/main/terraform) deploys a cluster with an ECS service running the Sinatra app. The app can be viewed by visiting https://ecs-cluster-staging-lb-1504765081.us-west-1.elb.amazonaws.com/. This url is subject to change. If deployed, the updated url can be retrieved from the apply output in the [Github CD workflow](https://github.com/markgllin/enzyme/actions/workflows/build_and_deploy.yml).

```
...
Apply complete! Resources: 25 added, 0 changed, 0 destroyed.

Outputs:

instance_ip_addr = "ecs-cluster-staging-lb-1504765081.us-west-1.elb.amazonaws.com"
```

## Local Development

### Requirements
- Docker (optional)
- Ruby v3.1.2
- Terraform v1.1.9
- AWS account

### Docker
You can build the image locally:
```
docker build -t enzyme-results .
```
And view the results by visiting `http://localhost` after starting the server with the following command:
```
docker run -it -p 80:80 enzyme-results
```

### Without Docker
Without docker, ruby 3.1.2 needs to be installed. Build dependencies for puma & sinatra may also be required, depending on the system.

```
# Start server
ruby lib/sinatra.rb

# Run specs
ruby spec/enzyme_test_cases.rb
```