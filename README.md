# AWS application load balancer Terraform module

Terraform module which creates an application load balancer on AWS.

## Terraform versions

Terraform 0.12 and newer. 

## Usage

```hcl
module "loadbalancer" {
  source                                = "/path/to/module/terraform-aws-alb"
  name                                  = var.name
  region                                = var.region
  vpc_cidr                              = var.vpc_cidr
  vpc_id                                = var.vpc_id
  subnet_ids                            = var.subnet_ids
  target_ids                            = var.target_ids
  target_group_port                     = "443"
  target_group_protocol                 = "HTTPS"
  ip_address_type                       = var.ip_address_type
  listener_https                        = true
  listener_certificate_arn              = var.listener_certificate_arn
  listener_additional_certificates_arns = var.listener_additional_certificates_arns

  enable_athena_access_logs_s3          = true
  athena_access_logs_s3_db_name         = var.athena_access_logs_s3_db_name

  sg_rules_ingress_cidr_map         = {
    internet_http = {
      port          = 80
      cidr_block    = "0.0.0.0/0"
    }
    internet_https = {
      port          = 443
      cidr_block    = "0.0.0.0/0"
    }
  }

  tags = {
    Environment = var.environment,
    Tier        = var.web_tier
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.65 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_athena_database.alb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_database) | resource |
| [aws_lb.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.frontend_http_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.frontend_https_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_certificate.frontend_https_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.main_to_webserver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_s3_bucket.alb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.athena_results_alb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.alb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.alb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.athena_results_alb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.in-each-port-alb-from-cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.out-any-alb-to-webserver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.out-each-port-alb-to-cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_elb_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_s3_bucket_name"></a> [access\_logs\_s3\_bucket\_name](#input\_access\_logs\_s3\_bucket\_name) | Name of the S3 bucket for access logs of Load Balancer | 
`string` | `null` | no |
| <a name="input_access_logs_s3_expiration_days"></a> [access\_logs\_s3\_expiration\_days](#input\_access\_logs\_s3\_expiration\_days) | Amount of days for expiration of S3 access logs of Load Balancer | `number` | `90` | no |
| <a name="input_access_logs_s3_transition_days"></a> [access\_logs\_s3\_transition\_days](#input\_access\_logs\_s3\_transition\_days) | Amount of days for S3 storage class to transition of access logs of Load Balancer | `number` | `30` | no |
| <a name="input_access_logs_s3_transition_storage_class"></a> [access\_logs\_s3\_transition\_storage\_class](#input\_access\_logs\_s3\_transition\_storage\_class) | S3 storage class to transition access logs of Load Balancer after amount of days | `string` | `"STANDARD_IA"` | no |
| <a name="input_athena_access_logs_s3_db_name"></a> [athena\_access\_logs\_s3\_db\_name](#input\_athena\_access\_logs\_s3\_db\_name) | AWS Athena Database name for ALB access logging | `string` | `"alb_logs"` | no |
| <a name="input_athena_access_logs_s3_expiration_days"></a> [athena\_access\_logs\_s3\_expiration\_days](#input\_athena\_access\_logs\_s3\_expiration\_days) | Amount of days for expiration of S3 results of AWS Athena | `number` | `30` | no |
| <a name="input_enable_any_egress_to_vpc"></a> [enable\_any\_egress\_to\_vpc](#input\_enable\_any\_egress\_to\_vpc) | Enable any egress traffic from Load Balancer instance to VPC | 
`bool` | `true` | no |
| <a name="input_enable_athena_access_logs_s3"></a> [enable\_athena\_access\_logs\_s3](#input\_enable\_athena\_access\_logs\_s3) | Enable AWS Athena for ALB access logging analysis | `bool` | `false` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | A boolean flag to determine whether the Load Balancer should be internal | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | IP address type of Load Balancer | `string` | `"ipv4"` | no |
| <a name="input_listener_additional_certificates_arns"></a> [listener\_additional\_certificates\_arns](#input\_listener\_additional\_certificates\_arns) | List of SSL certificates of Load Balancer listener | `list(string)` | `[]` | no |
| <a name="input_listener_certificate_arn"></a> [listener\_certificate\_arn](#input\_listener\_certificate\_arn) | SSL certificate of Load Balancer listener | `string` | `null` | no 
|
| <a name="input_listener_http"></a> [listener\_http](#input\_listener\_http) | Create listener for HTTP | `bool` | `true` | no |
| <a name="input_listener_http_port"></a> [listener\_http\_port](#input\_listener\_http\_port) | Port of HTTP listener | `string` | `"80"` | no |
| <a name="input_listener_https"></a> [listener\_https](#input\_listener\_https) | Create listener for HTTPS | `bool` | `false` | no |
| <a name="input_listener_https_port"></a> [listener\_https\_port](#input\_listener\_https\_port) | Port of HTTPS listener | `string` | `"443"` | no |
| <a name="input_listener_ssl_policy"></a> [listener\_ssl\_policy](#input\_listener\_ssl\_policy) | SSL policy of Load Balancer listener | `string` | `"ELBSecurityPolicy-2016-08"` | 
no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Name of region | `string` | n/a | yes |
| <a name="input_sg_description"></a> [sg\_description](#input\_sg\_description) | Description to be used for security group | `string` | `null` | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | Name to be used for security group | `string` | `null` | no |
| <a name="input_sg_rules_egress_cidr_map"></a> [sg\_rules\_egress\_cidr\_map](#input\_sg\_rules\_egress\_cidr\_map) | Map of security group rules for egress communication of cidr | 
`map` | `{}` | no |
| <a name="input_sg_rules_ingress_cidr_map"></a> [sg\_rules\_ingress\_cidr\_map](#input\_sg\_rules\_ingress\_cidr\_map) | Map of security group rules for ingress communication of cidr | `map` | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of VPC Subnet IDs to launch in | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_target_group_health_check_healthy_threshold"></a> [target\_group\_health\_check\_healthy\_threshold](#input\_target\_group\_health\_check\_healthy\_threshold) | Healthy threshold of target group health check | `string` | `"3"` | no |
| <a name="input_target_group_health_check_interval"></a> [target\_group\_health\_check\_interval](#input\_target\_group\_health\_check\_interval) | Interval of target group health check | `string` | `"30"` | no |
| <a name="input_target_group_health_check_matcher"></a> [target\_group\_health\_check\_matcher](#input\_target\_group\_health\_check\_matcher) | Matcher of target group health check | `string` | `"200"` | no |
| <a name="input_target_group_health_check_path"></a> [target\_group\_health\_check\_path](#input\_target\_group\_health\_check\_path) | Path of target group health check | `string` 
| `"/"` | no |
| <a name="input_target_group_health_check_port"></a> [target\_group\_health\_check\_port](#input\_target\_group\_health\_check\_port) | Port of target group health check | `string` 
| `"80"` | no |
| <a name="input_target_group_health_check_protocol"></a> [target\_group\_health\_check\_protocol](#input\_target\_group\_health\_check\_protocol) | Protocol of target group health check | `string` | `"HTTP"` | no |
| <a name="input_target_group_health_check_timeout"></a> [target\_group\_health\_check\_timeout](#input\_target\_group\_health\_check\_timeout) | Timeout of target group health check | `string` | `"5"` | no |
| <a name="input_target_group_health_check_unhealthy_threshold"></a> [target\_group\_health\_check\_unhealthy\_threshold](#input\_target\_group\_health\_check\_unhealthy\_threshold) 
| Unhealthy threshold of target group health check | `string` | `"2"` | no |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | Port of target group | `string` | `"80"` | no |
| <a name="input_target_group_protocol"></a> [target\_group\_protocol](#input\_target\_group\_protocol) | Protocol of target group | `string` | `"HTTP"` | no |
| <a name="input_target_group_target_type"></a> [target\_group\_target\_type](#input\_target\_group\_target\_type) | Target type of target group | `string` | `"instance"` | no |     
| <a name="input_target_ids"></a> [target\_ids](#input\_target\_ids) | A list of EC2 instance ids | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC cidr for security group rules | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | String of vpc id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name_alb"></a> [dns\_name\_alb](#output\_dns\_name\_alb) | DNS Name of application load balancer |
| <a name="output_name_alb"></a> [name\_alb](#output\_name\_alb) | Name of application load balancer |
| <a name="output_security_group_id_alb"></a> [security\_group\_id\_alb](#output\_security\_group\_id\_alb) | ID of security group to use for the application load balancer |

## Authors

Module managed by [Marcel Emmert](https://github.com/echomike80).

## License

Apache 2 Licensed. See LICENSE for full details.
