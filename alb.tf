resource "aws_lb" "atrato-alb" {
  name               = "atrato-alb"
  subnets            = [aws_subnet.public_subnet.id]
  security_groups    = [aws_security_group.sg_alb.id]
  load_balancer_type = "application"
  internal           = false

  tags = {
    Name = "PublicALB"
  }
}

#Target group
resource "aws_lb_target_group" "ec2_tg" {
  name     = "ec2-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.ec2_tg.arn
  target_id        = aws_instance.atrato_ec2.id

  depends_on = [aws_lb_target_group.ec2_tg]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.atrato-alb.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_tg.arn
  }
}

resource "aws_lb_listener_rule" "listener-rule" {
  listener_arn = aws_lb_listener.http.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_tg.arn
  }

  condition {
    host_header {
      values = ["*"]
    }
  }
}