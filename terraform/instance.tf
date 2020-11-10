resource "aws_key_pair" "infra_key"{
  key_name               = var.KEY_NAME
  public_key             = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "app-1" {
  ami                    = var.AMI
  instance_type          = "t2.micro"
  subnet_id              = "aws_subnet.${var.SUBNET1_NAME}.id"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id , aws_security_group.allow-http.id , aws_security_group.allow-https.id]
  key_name= var.KEY_NAME

  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i ‘aws_instance.${var.INSTANCE1_NAME}.public_ip},’ ../ansible-playbook/main.yml"

  }
  connection {
    host                = "aws_instance.${var.INSTANCE1_NAME}.public_ip"
    user                 = var.INSTANCE_USERNAME
    private_key          = file(var.PATH_TO_PRIVATE_KEY)
  }
  tags = {
    Name = var.INSTANCE1_NAME
  }
}

resource "aws_instance" "app-2" {
  ami                    = var.AMI
  instance_type          = "t2.micro"
  subnet_id              = "aws_subnet.${var.SUBNET2_NAME}.id"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id , aws_security_group.allow-http.id , aws_security_group.allow-https.id ]
  key_name= var.KEY_NAME
  provisioner "local-exec" {
    command= "ansible-playbook -u ${var.INSTANCE_USERNAME} -i ‘aws_instance.${var.INSTANCE2_NAME}.public_ip,’ ../ansible-playbook/main.yml"

  }
  connection {
    host                 = "aws_instance.${var.INSTANCE1_NAME}.public_ip"
    user                 = var.INSTANCE_USERNAME
    private_key          = file(var.PATH_TO_PRIVATE_KEY)
  }
  tags = {
    Name = var.INSTANCE2_NAME
  }
}
