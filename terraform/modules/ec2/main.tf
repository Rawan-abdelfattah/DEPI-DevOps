// for referneces and guides scroll to the bottom.

resource "aws_instance" "db" {
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id     = var.db_subnet_id
  vpc_security_group_ids = [aws_security_group.backend_sg.id, aws_security_group.base_sg.id]
#   lifecycle {
#     prevent_destroy = true
#   }
  key_name = aws_key_pair.mykeypair.key_name
  tags = {
    "Name" = "db-server"
    "private_name" = "db-server"
    "public_name" = "db-server"
  }
}

resource "aws_instance" "backend" {
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id     = var.backend_subnet_id
  vpc_security_group_ids = [aws_security_group.backend_sg.id, aws_security_group.base_sg.id]
  depends_on = [aws_instance.db]
  key_name = aws_key_pair.mykeypair.key_name
  tags = {
    "Name" = "backend-server"
    "private_name" = "backend-server"
    "public_name" = "backend-server"
  }
}

resource "aws_instance" "frontend" {
  ami           = var.ami
  instance_type = "t3.micro"
  subnet_id     = var.frontend_subnet_id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id, aws_security_group.bastion-allow-ssh.id, aws_security_group.base_sg.id]
  depends_on = [aws_instance.backend]
  associate_public_ip_address = true
  key_name = aws_key_pair.mykeypair.key_name
  
  tags = {
    "Name" = "frontend-server"
    "private_name" = "frontend-server"
    "public_name" = "frontend-server"
  }
}


resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "bastion-allow-ssh" {
  vpc_id      = var.vpc_id
  name        = "bastion-allow-ssh"
  description = "security group for bastion that allows ssh and all egress traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion-allow-ssh"
  }
}

resource "aws_security_group" "base_sg" {
  name        = "base-sg"
  vpc_id      = var.vpc_id

  // to allow ping
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // to allow outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend_sg" { // private security grp
  name        = "backend-sg"
  vpc_id      = var.vpc_id

  // for database access
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = ["${aws_security_group.frontend_sg.id}"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    security_groups = ["${aws_security_group.frontend_sg.id}"]

  }

  // allow ssh only from bastion
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [ aws_security_group.bastion-allow-ssh.id ]
  }

}

// used references:
// -----------------
// for bastion server setup:
// https://cyberpadawan.dev/terraform-code-to-deploy-bastion-host-and-private-instance-in-aws
// -----------------
// for terraform + ansible setup and servers security groups:
// https://www.itwonderlab.com/terraform-aws-ansible/
