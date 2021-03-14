##############
# Data sources
##############
data "aws_caller_identity" "current" {
}

data "aws_elb_service_account" "main" {
}

#################
# Security Groups
#################
resource "aws_security_group" "alb" {
  name        = var.name
  description = "Rules for application load balancer"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      Name = var.name
    },
    var.tags,
  )
}

resource "aws_security_group_rule" "in-each-port-alb-from-cidr" {
  for_each          = var.sg_rules_ingress_cidr_map
  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = [each.value.cidr_block]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "out-each-port-alb-to-cidr" {
  for_each          = var.sg_rules_egress_cidr_map
  type              = "egress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = [each.value.cidr_block]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "out-any-alb-to-webserver" {
  count             = var.enable_any_egress_to_vpc ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.alb.id
}

##############
# Loadbalancer
##############
resource "aws_lb" "application" {
  load_balancer_type   = "application"
  name                 = var.name
  internal             = false
  security_groups      = [aws_security_group.alb.id]
  subnets              = var.subnet_ids
  ip_address_type      = var.ip_address_type

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    enabled = true
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags,
  )
}

resource "aws_lb_target_group" "main" {
  name                 = var.name
  vpc_id               = var.vpc_id
  port                 = var.target_group_port
  protocol             = "HTTP"
  target_type          = "instance"
  health_check {
    interval            = var.target_group_health_check_interval
    path                = var.target_group_health_check_path
    port                = var.target_group_health_check_port
    healthy_threshold   = var.target_group_health_check_healthy_threshold
    unhealthy_threshold = var.target_group_health_check_unhealthy_threshold
    timeout             = var.target_group_health_check_timeout
    protocol            = var.target_group_health_check_protocol
    matcher             = var.target_group_health_check_matcher
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags,
  )

  depends_on = [aws_lb.application]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "main_to_webserver" {
  count            = length(var.target_ids)
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = element(var.target_ids, count.index)
  port             = var.target_group_port
}

resource "aws_lb_listener" "frontend_http_tcp" {
  count              = var.listener_http ? 1 : 0
  load_balancer_arn  = aws_lb.application.arn
  port               = var.listener_http_port
  protocol           = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "frontend_https_tcp" {
  count             = var.listener_certificate_arn != null ? 1 : 0
  load_balancer_arn = aws_lb.application.arn
  port              = var.listener_https_port
  protocol          = "HTTPS"
  ssl_policy        = var.listener_ssl_policy
  certificate_arn   = var.listener_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

################
# S3 Access Logs
################
resource "aws_s3_bucket" "alb_logs" {
  bucket = var.name
  acl    = "private"

  lifecycle_rule {
    id      = "log"
    enabled = true

    tags = {
      "rule"      = "log"
      "autoclean" = "true"
    }

    transition {
      days          = var.access_logs_s3_transition_days
      storage_class = var.access_logs_s3_transition_storage_class
    }

    expiration {
      days = var.access_logs_s3_expiration_days
    }
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags,
  )
}

resource "aws_s3_bucket_public_access_block" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

  block_public_acls         = true
  block_public_policy       = true
  ignore_public_acls        = true
  restrict_public_buckets   = true
}

# sources:
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_elb_service_account.main.id}:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.alb_logs.bucket}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.alb_logs.bucket}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.alb_logs.bucket}"
    }
  ]
}
POLICY
}