# Application Load Balancer
resource "aws_lb" "application" {
  name               = "ERI-app-load-balancer"
  internal           = false                  # Make it internet-facing
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.default.ids # Default public subnets
}


# Target Group
resource "aws_lb_target_group" "tg" {
  name     = "ERI-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

# Listener for ALB
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
