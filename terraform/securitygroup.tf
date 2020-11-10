resource "aws_security_group" "allow-ssh" {
  vpc_id       = "aws_vpc.${var.VPC_NAME}.id"
  name         = "allow-ssh"
  description  = "security group that allows ssh and all egress traffic"
  egress {
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      cidr_blocks  = ["0.0.0.0/0"]
  }
  ingress {
      from_port    = 22
      to_port      = 22
      protocol     = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}
resource "aws_security_group" "allow-http" {
  vpc_id       = "aws_vpc.${var.VPC_NAME}.id"
  name         = "allow-http"
  description  = "security group that allows http and all egress traffic"
  egress {
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      cidr_blocks  = ["0.0.0.0/0"]
  }
  ingress {
      from_port    = 80
      to_port      = 80
      protocol     = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-http"
  }
}
resource "aws_security_group" "allow-https" {
  vpc_id       = "aws_vpc.${var.VPC_NAME}.id"
  name         = "allow-https"
  description  = "security group that allows https and all egress traffic"
  egress {
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      cidr_blocks  = ["0.0.0.0/0"]
  }
  ingress {
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-https"
  }
}
