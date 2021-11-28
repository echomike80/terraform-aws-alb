output "dns_name_alb" {
  description = "DNS Name of application load balancer"
  value = aws_lb.application.dns_name
}

output "name_alb" {
  description = "Name of application load balancer"
  value = aws_lb.application.name
}

output "security_group_id_alb" {
  description = "ID of security group to use for the application load balancer"
  value = aws_security_group.alb.id
}