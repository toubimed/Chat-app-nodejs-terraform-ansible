resource "aws_alb" "app-alb" {
  name            = var.ALB_NAME
  subnets         = ["aws_subnet.${var.SUBNET1_NAME}.id", "aws_subnet.${var.SUBNET2_NAME}.id"]
  security_groups  = [aws_security_group.allow-http.id , aws_security_group.allow-https.id]
}

resource "aws_alb_target_group" "alb-target-group" {
  name            = var.ALB_TARGET_GROUP
  port            = "80"
  protocol        = "HTTP"
  vpc_id          = "aws_vpc.${var.VPC_NAME}.id"
}

resource "aws_alb_target_group_attachment" "alb-attachment-1" {
  target_group_arn = "aws_alb_target_group.${var.ALB_TARGET_GROUP}.arn"
  target_id        = "aws_instance.${var.INSTANCE1_NAME}.id"
  port             = "5000"
}

resource "aws_alb_target_group_attachment" "alb-attachment-2" {
  target_group_arn = "aws_alb_target_group.${var.ALB_TARGET_GROUP}.arn"
  target_id        = "aws_instance.${var.INSTANCE2_NAME}.id"
  port             = "5000"
}

resource "aws_alb_listener" "frontend-listener" {
  load_balancer_arn = "aws_alb.${var.ALB_NAME}.arn"
  port = "80"
  default_action{
    target_group_arn  = "aws_alb_target_group.${var.ALB_TARGET_GROUP}.arn"
    type              = "forward"
  }
}
resource "aws_alb_listener_rule" "alb-rule" {
  listener_arn        = aws_alb_listener.frontend-listener.arn
  priority            = 100
  action{
    type              = "forward"
    target_group_arn  = "aws_alb_target_group.${var.ALB_TARGET_GROUP}.arn"
  }
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = "aws_alb_target_group.${var.ALB_TARGET_GROUP}.arn"
  }

}
