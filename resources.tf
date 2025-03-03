resource "aws_vpc" "test" {
  cidr_block = "192.168.0.0/22"

  tags = {
    Name = "testvpc"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "test-subnet"
  }
}



resource "aws_instance" "main" {
  ami           = data.aws_ami.awslinux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.test_subnet.id

  tags = {
    Name = "HelloWorld"
  }
}

output "value_of_instance_ip" {
  value = aws_instance.main.public_ip
}
resource "aws_vpc" "dev" {
  cidr_block = "192.168.0.0/20"

  tags = {
    Name = "devvpc"
  }
}
data "aws_ami" "awslinux" {
  most_recent = true
  owners      = ["137112412989"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20250218.2-kernel-6.1-x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}
