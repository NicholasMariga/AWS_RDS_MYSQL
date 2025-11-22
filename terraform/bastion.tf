

resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami
  instance_type               = var.instance_type_bastion
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "${var.project_name}-bastion"
  }
}
