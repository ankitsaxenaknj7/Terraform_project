provider "aws" {
  region     = "ap-southeast-1"
  access_key = "AKIAUHCBWTZ44T2O4IO6"
  secret_key = "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"
}

resource "aws_vpc" "HCL-VPC" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "HCL-VPC"
  }
}

resource "aws_subnet" "Subnet01" {
  vpc_id            = aws_vpc.HCL-VPC.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Subnet01"
  }
}

resource "aws_network_interface" "NIC01" {
  subnet_id   = aws_subnet.Subnet01.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "NIC01"
  }
}

resource "aws_instance" "Instance01" {
  ami           = "ami-005e54dee72cc1d00" # ap-southeast-1a
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.NIC01.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}

