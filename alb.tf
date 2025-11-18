#application load balancer
resource "aws_lb" "alb" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [
    aws_subnet.dev_proj_1_public_subnets_1.id,
    aws_subnet.dev_proj_1_public_subnets_2.id
  ]
}

#target group
resource "aws_lb_target_group" "tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.dev_proj_1_vpc_ap_south_1.id
}

# Add ec2 instance web_a in a target grp
resource "aws_lb_target_group_attachment" "a" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web_a.id
  port             = 80
}

# Add ec2 instance web_b in a target grp
resource "aws_lb_target_group_attachment" "b" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web_b.id
  port             = 80
}

# attach target gtp with alb
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}