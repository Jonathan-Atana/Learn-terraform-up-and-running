<!-- BEGIN_TF_DOCS -->
# Description

This module is designed to create a cluster of web server (2-10) using an Auto Scalling Group (ASG), which serve as target groups to a load balancer.
- The web servers accept inbound traffic only from the ALB's security group, and can route traffic to anywhere.
- The ALB allows incomming traffic on ports 80 and 443 (HTTP and HTTPS) from anywhere, and routes it to the web servers.
- The ASG can scale the num of servers up or down according to traffic, with scheduled actions to scale up during business hours and scale down at night.

## Usage

To use this configuration, ensure you have the necessary AWS credentials set up and run:

```bash
terraform init
terraform plan
terraform apply
```

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.99.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_webserver_cluster"></a> [webserver\_cluster](#module\_webserver\_cluster) | github.com/Jonathan-Atana/terraform-modules/services/webserver-cluster | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_schedule.scale_down](https://registry.terraform.io/providers/hashicorp/aws/5.99.0/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.scale_up](https://registry.terraform.io/providers/hashicorp/aws/5.99.0/docs/resources/autoscaling_schedule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The S3 bucket to use | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb-dns-name"></a> [alb-dns-name](#output\_alb-dns-name) | The domain name of the load balancer |

---

## Additional Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Terraform Module Registry](https://registry.terraform.io/)
- [Best Practices for Module Development](https://developer.hashicorp.com/terraform/language/modules/develop)

## Authors

- **Author:** Jonathan
- **Generated on:** 2025-06-06
<!-- END_TF_DOCS -->