#RDS
resource "aws_security_group" "rds_security_group" {
  name        = "rds-sg"
  description = "Security Group para RDS"
  vpc_id      = var.vpc

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_instance.atrato_ec2.private_ip]
  }
}

#EC2
resource "aws_security_group" "ec2_SG" {
  name        = "ec2_allow_alb"
  description = "Allow traffic from ALB"
  vpc_id      = var.vpc

  ingress {
    description = "Allow traffic from ALB"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow SSH access"
  vpc_id      = var.vpc

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh]
  }
}

#ALB
resource "aws_security_group" "sg_alb" {
  name        = "load-balancer-sg"
  description = "Security Group for Load Balancer"
  vpc_id      = var.vpc

  # Regla para permitir tráfico desde el Internet Gateway (IGW)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla para permitir tráfico desde la instancia
  ingress {
    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
