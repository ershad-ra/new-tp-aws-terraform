resource "aws_launch_template" "lt" {
  name          = "ERI-app-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = true # Assign public IP
    security_groups             = [aws_security_group.asg_sg.id]
  }
}