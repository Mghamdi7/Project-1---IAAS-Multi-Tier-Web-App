# resource "aws_launch_configuration" "Scaled_instance" {
#   name_prefix     = "Scaled_launch_instance"
#   image_id        = "ami-0dfcb1ef8550277af"
#   instance_type   = "t2.micro"
#   security_groups = [aws_security_group.WebSG.id]

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# resource "aws_autoscaling_group" "ec2_auto_scaling" {
#   min_size             = 1
#   max_size             = 3
#   desired_capacity     = 1
#   launch_configuration = aws_launch_configuration.Scaled_instance.name
#   vpc_zone_identifier  = [aws_subnet.private_subnets["us-east-1a"].id, aws_subnet.private_subnets["us-east-1b"].id]
# }


# resource "aws_autoscaling_attachment" "asg_target" {
#   autoscaling_group_name = aws_autoscaling_group.ec2_auto_scaling.id
#   lb_target_group_arn    = aws_lb_target_group.project_tg.arn
# }