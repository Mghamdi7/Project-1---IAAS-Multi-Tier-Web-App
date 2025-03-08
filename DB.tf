# resource "aws_db_instance" "rds_instance" {
#   allocated_storage      = 20
#   identifier             = "rds-terraform"
#   storage_type           = "gp2"
#   engine                 = "mysql"
#   engine_version         = "8.0.27"
#   instance_class         = "db.t2.micro"
#   db_name                = "project_rds"
#   username               = "dolfined"
#   password               = "dolfined"
#   publicly_accessible    = false
#   skip_final_snapshot    = true
#   db_subnet_group_name   = aws_db_subnet_group.db_subnet.id
#   vpc_security_group_ids = [aws_security_group.db_sg.id]
#   tags = {
#     Name = "ExampleRDSServerInstance"
#   }
# }