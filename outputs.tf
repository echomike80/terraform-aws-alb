output "security_group_id_alb" {
  description = "ID of security group to use for the application load balancer"
  value = aws_security_group.alb.id
}