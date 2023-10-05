resource "aws_instance" "atrato_ec2" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_ec2_id
  security_groups = [aws_security_group.ec2_SG.id,
  aws_security_group.ssh.id]
  user_data = file("userdata.sh")

  tags = {
    Name = "atrato_ec2"
  }
}

resource "aws_ami_from_instance" "atrato_ami_terra" {
  name               = "atrato_ami_terra"
  source_instance_id = aws_instance.atrato_ec2.id
  depends_on         = [aws_instance.atrato_ec2]
}
