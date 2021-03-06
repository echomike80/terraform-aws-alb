# AWS application load balancer Terraform module

Terraform module which creates an application load balancer on AWS.

## Terraform versions

Terraform 0.12 and newer. 

## Usage

```hcl
module "loadbalancer" {
  source                            = "/path/to/module/terraform-aws-alb"
  name                              = var.name
  region                            = var.region
  vpc_cidr                          = var.vpc_cidr
  vpc_id                            = var.vpc_id
  subnet_ids                        = var.subnet_ids
  target_ids                        = var.target_ids
  ip_address_type                   = var.web_alb_ip_address_type
  listener_certificate_arn          = var.listener_certificate_arn

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
    Project     = var.project,
    Tier        = var.web_tier
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | >= 2.65 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.65 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_logs\_s3\_expiration\_days | Amount of days for expiration of S3 access logs of Load Balancer | `number` | `90` | no |
| access\_logs\_s3\_transition\_days | Amount of days for S3 storage class to transition of access logs of Load Balancer | `number` | `30` | no |
| access\_logs\_s3\_transition\_storage\_class | S3 storage class to transition access logs of Load Balancer after amount of days | `string` | `"STANDARD_IA"` | no |
| enable\_any\_egress\_to\_vpc | Enable any egress traffic from Load Balancer instance to VPC | `bool` | `true` | no |
| ip\_address\_type | IP address type of Load Balancer | `string` | `"ipv4"` | no |
| listener\_certificate\_arn | SSL certificate of Load Balancer listener | `string` | `null` | no |
| listener\_http | Create listener for HTTP | `bool` | `true` | no |
| listener\_http\_port | Port of http listener | `string` | `"80"` | no |
| listener\_https\_port | Port of https listener | `string` | `"443"` | no |
| listener\_ssl\_policy | SSL policy of Load Balancer listener | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| name | Name to be used on all resources as prefix | `string` | n/a | yes |
| region | Name of region | `string` | n/a | yes |
| sg\_rules\_egress\_cidr\_map | Map of security group rules for egress communication of cidr | `map` | `{}` | no |
| sg\_rules\_ingress\_cidr\_map | Map of security group rules for ingress communication of cidr | `map` | `{}` | no |
| subnet\_ids | A list of VPC Subnet IDs to launch in | `list(string)` | `[]` | no |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| target\_group\_health\_check\_healthy\_threshold | Healthy threshold of target group health check | `string` | `"3"` | no |
| target\_group\_health\_check\_interval | Interval of target group health check | `string` | `"30"` | no |
| target\_group\_health\_check\_matcher | Matcher of target group health check | `string` | `"200"` | no |
| target\_group\_health\_check\_path | Path of target group health check | `string` | `"/"` | no |
| target\_group\_health\_check\_port | Port of target group health check | `string` | `"80"` | no |
| target\_group\_health\_check\_protocol | Protocol of target group health check | `string` | `"HTTP"` | no |
| target\_group\_health\_check\_timeout | Timeout of target group health check | `string` | `"5"` | no |
| target\_group\_health\_check\_unhealthy\_threshold | Unhealthy threshold of target group health check | `string` | `"2"` | no |
| target\_group\_port | Port of target group | `string` | `"80"` | no |
| target\_ids | A list of EC2 instance ids | `list(string)` | n/a | yes |
| vpc\_cidr | VPC cidr for security group rules | `string` | `"10.0.0.0/16"` | no |
| vpc\_id | String of vpc id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_id\_alb | ID of security group to use for the application load balancer |

## Authors

Module managed by [Marcel Emmert](https://github.com/echomike80).

## License

Apache 2 Licensed. See LICENSE for full details.
