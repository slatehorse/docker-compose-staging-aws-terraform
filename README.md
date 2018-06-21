TODO: describe this project

- Bastion host
- Route53
- target groups/ https/http listener port config

# TODO costs

- EC2 bastion host
- EC2 docker-compose host

## TODO deploying your app

## Using SSH-agent

- needed for agent-forwarding to private network

## Getting set up
Ensure you have your AWS credential set as environment variables:

> Tip: add your credentials to `.env` and prime your shell using `source .env`.

```
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
```

Next, [create an S3 bucket](https://s3.console.aws.amazon.com/s3/home) to store our Terraform state centrally.

Next, rename `development.tfvars.sample` to `development.tfvars` and update to match your requirements.

Now you're ready to initialise Terraform:

```bash
terraform init
```

The `key` setting just provides a prefix to the statefile – this can be set to `staging.tfstate` for now.

Now you're all set up and ready to deploy.

## Deploying the infrastructure

The service can be deployed/updated with:

```
terraform apply -var-file=development.tfvars
```
