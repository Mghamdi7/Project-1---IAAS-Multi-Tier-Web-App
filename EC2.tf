resource "aws_key_pair" "MyKey_SSH" {
  key_name   = "MyKey"
  public_key = file("~/.ssh/MyKey.pub")
}

resource "aws_instance" "web" {
  ami                    = "ami-0dfcb1ef8550277af"
  instance_type          = "t2.micro"
  key_name               = "MyKey"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.WebSG.id]
  subnet_id              = aws_subnet.private_subnets["us-east-1a"].id
  root_block_device {
    encrypted = true
  }
  user_data = <<-EOF
    #!/bin/bash
        yum update -y
        yum install httpd -y     
        systemctl start httpd    
        systemctl enable httpd   
        echo "This is server *1* in AWS Region US-EAST-1 in AZ US-EAST-1B " > /var/www/html/index.html
        EOF
  tags = {
    Name = "web_instance"
  }
}
resource "aws_instance" "app" {
  ami                    = "ami-0dfcb1ef8550277af"
  instance_type          = "t2.micro"
  key_name               = "MyKey"
  availability_zone      = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.WebSG.id]
  subnet_id              = aws_subnet.private_subnets["us-east-1b"].id
  root_block_device {
    encrypted = true
  }
  user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y     
        systemctl start httpd    
        systemctl enable httpd   
        echo "This is server *1* in AWS Region US-EAST-1 in AZ US-EAST-1B " > /var/www/html/index.html
        EOF
  tags = {
    Name = "APP_instance"
  }
}