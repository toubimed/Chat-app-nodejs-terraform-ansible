# Chat-App-using-Socket.io
A simple chat app using socket.io

See it in action - [Kunal Chat App](https://kunal-chat-app.herokuapp.com)

##   step 1

this following file [VPC](terraform/vpc.tf) create VPC resources on AWS with 2 public subnets in two different availability zones. and provide this settings:
- Create a 2 public Subnet in 2 different availability zone
- Create a route table to route outbound Internet traffic through internet gateway
- Create internet gateway
- Create route table association for each subnet

### Variables related to step 1

| Name | Description | Type | Default |
|------|-------------|------|---------|
| AMI | ID of AMI to use for the instance | `string` | ami-0739f8cdb239fe9ae |
|VPC_NAME| Name of the VPC | `string` | app-vpc |
|VPC_CIDR_BLOCK| Specify the IPv4 CIDR block for the VPC| `string`| 10.0.0.0/16 |
|SUBNET`x`_CIDR_BLOCK| block of public IP addresses assigned to the instances | `string` | 10.0.1.0/24 and 10.0.2.0/24|
|AZ`x`| availability zones of the instance |`string`|us-east-1a and us-east-1b|
|SUBNET`x`_NAME|Name of the subnets| `string` | subnet-1 and subnet-2|
|GW_NAME| Name of the gateway | `string` | app-gw |
|ROUTE_NAME|Name of the route table| `string` | app-route|


## step 2

this following file [instance](terraform/instance.tf) create 2 EC2 instances and provide this settings:
- asign each instance with public subnet and the VPC created in step1
- Upload the public key to each instance
- assign security group allow-ssh, allow-http, allow-https for each instance
- configure each instance with ansible playbook

### Variables related to step 2

| Name | Description | Type | Default |
|------|-------------|------|---------|
| KEY_NAME | The key name of the Key Pair to use for the instance | `string` | infra_key |
|PATH_TO_PUBLIC_KEY|Path to public key to be uploaded it can be generedted with ssh-keygen - out infra_key in the project folder |`file` |infra_key.pub|
|PATH_TO_PRIVATE_KEY|path to private key |`file`|infra_key |
|INSTANCE_USERNAME|username used to login to the instance|`string`|ubuntu |

## step 3

the following file [ALB](terraform/alb.tf) create application load balancer and provide this settings :
- Create ALB and assosiated with subnets and security group allow http and https traffic
- define target group to the back-end instances
- configure listener to accepts HTTP requests on port 80 and distributes them to the target group
- define rules

### Variables related to step 3

| Name | Description | Type | Default |
|------|-------------|------|---------|
| ALB_NAME | The key name of the Key Pair to use for the instance | `string` | app-alb |
|ALB_TARGET_GROUP|ALB_TARGET_GROUP|`string` | alb-target-group |


## step4

the following file [playbook](ansible-playbook/main.yml) outlines the app deployment strategy using Ansible. The strategy performs the following :

- Prepares the application environment
- push the applications from ansible controler to instances
- Installs the applications dependencies
- Daemonizes the application with pm2

### Variables related to step 4
| Name | Description | Default |
|------|-------------|---------|
| NODEJS_VERSION |  The Nodejs version to install |12 |
|appDir | >=2.8 |  the root app directory |/home/ubuntu/chatApp |


## Requirement

| Name | Version |
|------|-------------|
| terraform | >= 0.12 |
|ansible| >=2.8 |
|aws|>= 2.6|

## Quick start

Configure your AWS access keys as environment variables:

    export AWS_ACCESS_KEY_ID=(your access key id)
    export AWS_SECRET_ACCESS_KEY=(your secret access key)

Deploy the code:

    terraform init
    terraform apply

When the `apply` command completes, it will output the DNS name of the load balancer. To test the load balancer:

    curl http://<alb_dns_name>/
