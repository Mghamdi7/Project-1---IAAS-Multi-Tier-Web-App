resource "aws_security_group" "WebSG" {
  name   = "WebSG"
  vpc_id = aws_vpc.vpc.id
  
  
  
  dynamic "ingress" {
    for_each = var.allowed_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}















#Database SG
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "security group for RDS database"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = "0"
    to_port         = "0"
    protocol        = "-1"
    security_groups = [aws_security_group.WebSG.id]
  }
}