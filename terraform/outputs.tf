output "alb_dns_name" {
  value       = "aws_alb.${var.ALB_NAME}.dns_name"
  description = "The domain name of the load balancer"
}

output "public-ip-1"{
  value = "aws_instance.${var.INSTANCE1_NAME}.public_ip"
}

output "public-ip-2"{
  value = "aws_instance.${var.INSTANCE2_NAME}.public_ip"
}
