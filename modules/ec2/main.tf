resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}
#This is ec2 file
#this is the amazon linux 2 configuration
#testing