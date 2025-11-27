# Lookup latest Ubuntu 22.04 LTS AMI (Canonical)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.public_sg_id]

  # Attach key pair if provided (null if empty)
  key_name = var.key_name != "" ? var.key_name : null

  associate_public_ip_address = true

  user_data = var.user_data

  tags = {
    Name = "${var.project_name}-ec2"
  }
}
