terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "myfirsts3ketan"
    key    = "terraform.tfstate"
    region = "eu-north-1"  
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "server-1" {
  ami                    = "ami-080254318c2d8932f"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]

  tags = {
    name = "SampleServer"
  }

}

resource "aws_security_group" "ssh-sg" {
  name        = "allow-sshh"
  description = "allow the ssh to EC2"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "all-SSH"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}