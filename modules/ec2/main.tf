resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
#!/bin/bash

yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html << 'HTML'
${var.index_html}
HTML

cat > /var/www/html/style.css << 'CSS'
${var.style_css}
CSS

systemctl restart httpd
EOF

  tags = {
    Name = "Terraform-EC2"
  }
}