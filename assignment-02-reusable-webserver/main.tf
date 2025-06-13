provider "aws" {
  region  = var.aws_region
  profile = "akankssha"
}

resource "aws_vpc" "akankssha_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_akankssha" {
  vpc_id                  = aws_vpc.akankssha_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw_akankssha" {
  vpc_id = aws_vpc.akankssha_vpc.id
}

resource "aws_route_table" "public_akankssha" {
  vpc_id = aws_vpc.akankssha_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_akankssha.id
  }
}

resource "aws_route_table_association" "public_akankssha" {
  subnet_id      = aws_subnet.public_akankssha.id
  route_table_id = aws_route_table.public_akankssha.id
}

resource "aws_security_group" "web_sg_akankssha" {
  name   = "web-sg"
  vpc_id = aws_vpc.akankssha_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # You can replace with your IP like ["<your_ip>/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "my_web_server" {
  source = "./modules/ec2_instance"

  instance_type      = var.instance_type
  ami_id             = var.web_server_ami
  subnet_id          = aws_subnet.public_akankssha.id
  security_group_ids = [aws_security_group.web_sg_akankssha.id]

  tags = {
    Name = "akankssha-webserver"
  }
}
