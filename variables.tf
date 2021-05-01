variable "access_logs_s3_expiration_days" {
  description = "Amount of days for expiration of S3 access logs of Load Balancer"
  type        = number
  default     = 90
}

variable "access_logs_s3_transition_days" {
  description = "Amount of days for S3 storage class to transition of access logs of Load Balancer"
  type        = number
  default     = 30
}

variable "access_logs_s3_transition_storage_class" {
  description = "S3 storage class to transition access logs of Load Balancer after amount of days"
  type        = string
  default     = "STANDARD_IA" # or "ONEZONE_IA"
}

variable "athena_access_logs_s3_db_name" {
  description = "AWS Athena Database name for ALB access logging"
  type        = string
  default     = "alb_logs"
}

variable "athena_access_logs_s3_expiration_days" {
  description = "Amount of days for expiration of S3 results of AWS Athena"
  type        = number
  default     = 30
}

variable "enable_athena_access_logs_s3" {
  description = "Enable AWS Athena for ALB access logging analysis"
  type        = bool
  default     = false
}

variable "enable_any_egress_to_vpc" {
  description = "Enable any egress traffic from Load Balancer instance to VPC"
  type        = bool
  default     = true
}

variable "internal" {
  type        = bool
  default     = false
  description = "A boolean flag to determine whether the Load Balancer should be internal"
}

variable "ip_address_type" {
  description = "IP address type of Load Balancer"
  type        = string
  default     = "ipv4"
}

variable "listener_http" {
  description = "Create listener for HTTP"
  type        = bool
  default     = true
}

variable "listener_https" {
  description = "Create listener for HTTPS"
  type        = bool
  default     = false
}

variable "listener_http_port" {
  description = "Port of HTTP listener"
  type        = string
  default     = "80"
}

variable "listener_https_port" {
  description = "Port of HTTPS listener"
  type        = string
  default     = "443"
}

variable "listener_ssl_policy" {
  description = "SSL policy of Load Balancer listener"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "listener_certificate_arn" {
  description = "SSL certificate of Load Balancer listener"
  type        = string
  default     = null
}

variable "listener_additional_certificates_arns" {
  description = "List of SSL certificates of Load Balancer listener"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "region" {
  description = "Name of region"
  type        = string
}

variable "sg_rules_egress_cidr_map" {
  description = "Map of security group rules for egress communication of cidr"
  type        = map
  default     = {}
}

variable "sg_rules_ingress_cidr_map" {
  description = "Map of security group rules for ingress communication of cidr"
  type        = map
  default     = {}
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "target_group_health_check_interval" {
  description = "Interval of target group health check"
  type        = string
  default     = "30"
}

variable "target_group_health_check_path" {
  description = "Path of target group health check"
  type        = string
  default     = "/"
}

variable "target_group_health_check_port" {
  description = "Port of target group health check"
  type        = string
  default     = "80"
}

variable "target_group_health_check_healthy_threshold" {
  description = "Healthy threshold of target group health check"
  type        = string
  default     = "3"
}

variable "target_group_health_check_unhealthy_threshold" {
  description = "Unhealthy threshold of target group health check"
  type        = string
  default     = "2"
}

variable "target_group_health_check_timeout" {
  description = "Timeout of target group health check"
  type        = string
  default     = "5"
}

variable "target_group_health_check_protocol" {
  description = "Protocol of target group health check"
  type        = string
  default     = "HTTP"
}

variable "target_group_health_check_matcher" {
  description = "Matcher of target group health check"
  type        = string
  default     = "200"
}

variable "target_group_port" {
  description = "Port of target group"
  type        = string
  default     = "80"
}

variable "target_group_protocol" {
  description = "Protocol of target group"
  type        = string
  default     = "HTTP"
}

variable "target_group_target_type" {
  description = "Target type of target group"
  type        = string
  default     = "instance"
}

variable "target_ids" {
  description = "A list of EC2 instance ids"
  type        = list(string)
}

variable "vpc_id" {
  description = "String of vpc id"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC cidr for security group rules"
  type        = string
  default     = "10.0.0.0/16"
}