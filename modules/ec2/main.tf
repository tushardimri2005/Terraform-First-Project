resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  user_data = <<-EOF
              #!/bin/bash

              yum update -y
              yum install -y httpd

              systemctl start httpd
              systemctl enable httpd

              cat > /var/www/html/index.html <<HTML
              <!DOCTYPE html>
              <html>
              <head>
                <title>DevOps Demo</title>
              </head>
              <body>
                <h1>Website Deployed Automatically 🚀</h1>
              </body>
              </html>
              HTML

              EOF

  tags = {
    Name = "Terraform-EC2"
  }
}