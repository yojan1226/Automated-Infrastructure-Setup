resource "aws_instance" "web_a" {
  ami           = "ami-03695d52f0d883f65"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev_proj_1_public_subnets_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello from Subnet B" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "webServerA"
  }
}

resource "aws_instance" "web_b" {
  ami           = "ami-03695d52f0d883f65"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev_proj_1_public_subnets_2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "Hello from Subnet B" > /usr/share/nginx/html/index.html
              EOF

   tags = {
    Name = "WebServerB"
  }
}

resource "aws_key_pair" "ec2_key" {
    key_name = "id_ed25519"
    public_key = file("${path.module}/keys/id_ed25519.pub")

}

