# Terraform

This directory contains TF templates for creating the following resources:

- ECS cluster and service for Sinatra app
- ECR repo for hosting Sinatra image
- Networking infra (i.e. vpc, subnets, SGs etc.)

The Sinatra webapp is deployed to 2 subnets in the us-west-1 region and is loadbalanced round robin. This can be seen by continually refreshing the page and seeing the hostname change (if using the webapp in this repo). A self-signed cert is used for HTTPS.

The webapp can be visited at https://ecs-cluster-staging-lb-1504765081.us-west-1.elb.amazonaws.com/. This url changes if the infra is redeployed from scratch. If that happens, the updated url can be retrieved from the apply output in the [GH workflow](https://github.com/markgllin/enzyme/actions/workflows/build_and_deploy.yml).
```
...
Apply complete! Resources: 25 added, 0 changed, 0 destroyed.

Outputs:

instance_ip_addr = "ecs-cluster-staging-lb-1504765081.us-west-1.elb.amazonaws.com"
```
## Deployment

### Github Actions

To deploy this same infra to AWS via GH Actions, do the following:
1. clone the repo locally
2. update `main.tf` accordingly with your own remote backend configuration
3. Add `AWS_ACCESS_KEY_ID` & `AWS_SECRET_ACCESS_KEY` as repository secrets (ensure they have permissions to deploy to ECS)

On merge to main, deployments will automatically trigger (i.e. CD).
An option to manually deploy has also been added through a `workflow_dispatch`.

### From local

To deploy infra from local:
1. clone the repo
2. update remote backend configuration in `main.tf`
3. `terraform init` & `terraform apply`

The container image will need to be pushed to ECR manually or pulled from an accessible repo.