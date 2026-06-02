resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "Terraform-EC2"
  }
}