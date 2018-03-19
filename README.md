TODO: describe this project

- Bastion host
- Route53
- target groups/ https/http listener port config

# TODO costs

- NAT gateway
- EC2 bastion host
- EC2 docker-compose host

## TODO deploying your app

## Using SSH-agent

- needed for agent-forwarding to private network

## Getting set up
Ensure you have your AWS credential set as environment variables:

```
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
```

## Making development easier

We want to be able to run Terraform without needing to enter variables for every run.

To do this, create a file named `development.tfvars`, and add variables you set each time, e.g.:

```terraform
project_name = "my-special-project"

common_tags = {
  Client = "My Client Ltd",
  Project = "Example staging",
  Terraform = "true",
  Environment = "staging"
}
```

Then you can use these variables by specifying the file when you run Terraform, e.g.:

```bash
terraform plan -var-file=development.tfvars
```

> You can choose any name for this file.

