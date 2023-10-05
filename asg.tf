resource "aws_launch_configuration" "atrato_lc" {
  name_prefix                 = "atrato-lc"
  image_id                    = "aws_ami_from_instance.atrato_ami_terra.image_id"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.ec2_SG.id, aws_security_group.ssh.id]
  user_data                   = file("userdata.sh")
  associate_public_ip_address = true

  depends_on = [aws_ami_from_instance.atrato_ami_terra]
}

resource "aws_autoscaling_group" "atrato_asg" {
  name                 = "atrato-asg"
  launch_configuration = aws_launch_configuration.atrato_lc.name
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = [var.private_subnet_ec2_id]


  target_group_arns         = [aws_lb_target_group.ec2_tg.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                   = "cpu-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.atrato_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80
  }
}