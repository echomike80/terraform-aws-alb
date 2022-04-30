variable "access_logs_s3_bucket_name" {
  description = "Name of the S3 bucket for access logs of Load Balancer"
  type        = string
  default     = null
}

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

variable "athena_access_logs_s3_bucket_name" {
  description = "AWS Athena S3 bucket name for ALB access logging"
  type        = string
  default     = null
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

variable "deletion_protection_enabled" {
  description = "A boolean flag to enable/disable deletion protection for Load Balancer"
  type        = bool
  default     = false
}

variable "drop_invalid_header_fields_enabled" {
  description = "A boolean flag to enable/disable drop invalid header fields for Load Balancer"
  type        = bool
  default     = false
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

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 60
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

variable "sg_description" {
  description = "Description to be used for security group"
  type        = string
  default     = null
}

variable "sg_name" {
  description = "Name to be used for security group"
  type        = string
  default     = null
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

variable "target_group_stickiness_cookie_duration" {
  description = " The time period, in seconds, during which requests from a client should be routed to the same target"
  type        = string
  default     = "86400"
}

## issue: An argument named "cookie_name" is not expected here.
# variable "target_group_stickiness_cookie_name" {
#   description = "Name of the application based cookie. AWSALB, AWSALBAPP, and AWSALBTG prefixes are reserved and cannot be used."
#   type        = string
#   default     = null
# }

variable "target_group_stickiness_enabled" {
  description = "Boolean to enable / disable stickiness. Default is true."
  type        = bool
  default     = false
}

variable "target_group_stickiness_type" {
  description = "The type of sticky sessions. The only current possible values are lb_cookie, app_cookie for ALBs, and source_ip for NLBs."
  type        = string
  default     = "lb_cookie"
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