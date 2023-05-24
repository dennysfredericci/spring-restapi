## Spring-RestApi

This project serves a single endpoint that returns "Hello World" in JSON format. 

Its purpose is to the deployment testing of a Spring Boot application on AWS using Terraform.

AWS Resources used in this project:
* S3
* AppRunner
* IAM Role
* DynamoDB

## Requirements

Environment Variables:

```
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_ACCOUNT_ID="..."
```

Create the AWS resources below manually to manage the state of the terraform resources:

```
S3 Bucket:
    terraform-spring-restapi
    
DynamoDB Table: 
    terraform-spring-restapi-lock
    Key Schema: LockID (String) 
```

## Deploy on AWS

```
make all
```

## Destroy all AWS resources

```
make destroy
```
