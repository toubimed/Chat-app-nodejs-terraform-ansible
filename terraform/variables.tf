variable "AWS_ACCESS_KEY" {
  default= "AKIA5UNFMH73ICRHXTHP"
}
variable "AWS_SECRET_KEY" {
  default= "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"
}
variable "AWS_REGION" {
  default= "us-east-1"
}
variable "AMI" {
  default = "ami-0739f8cdb239fe9ae"
}
variable "VPC_CIDR_BLOCK" {
  default = "10.0.0.0/16"
}
variable "VPC_NAME" {
  default = "app-vpc"
}
variable "SUBNET1_CIDR_BLOCK" {
  default = "10.0.1.0/24"
}
variable "AZ1" {
  default = "us-east-1a"
}
variable "SUBNET1_NAME" {
  default = "subnet-1"
}
variable "SUBNET2_CIDR_BLOCK" {
  default = "10.0.2.0/24"
}
variable "AZ2" {
  default = "us-east-1b"
}
variable "SUBNET2_NAME" {
  default = "subnet-2"
}
variable "GW_NAME" {
  default = "app-gw"
}
variable "ROUTE_NAME" {
  default = "app-route"
}
variable "KEY_NAME" {
  default = "infra_key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "infra_key.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "infra_key"
}
variable "ALB_NAME" {
  default = "app-alb"
}
variable "ALB_TARGET_GROUP" {
  default = "alb-target-group"
}
variable "LISTENER_NAME" {
  default = "frontend-listener"
}
variable "INSTANCE1_NAME" {
  default = "app-2"
}
variable "INSTANCE2_NAME" {
  default = "app-2"
}
