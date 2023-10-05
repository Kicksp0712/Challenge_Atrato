resource "aws_db_instance" "atrato_rds" {
  identifier             = "atratords"
  allocated_storage      = 20
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  db_subnet_group_name   = var.private_subnet_rds
  vpc_security_group_ids = [var.rds_securityG]
  tags = {
    Name = "atrato_rds"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_network_traffic_alarm" {
  alarm_name          = "rds-network-traffic-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NetworkReceiveThroughput"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 1000000

  alarm_description = "Alarm for monitoring RDS network traffic"

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.atrato_rds.identifier
  }
}