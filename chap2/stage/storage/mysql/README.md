<!-- BEGIN_TF_DOCS -->
# Description

This Terraform configuration sets up a MySQL database

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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mysql"></a> [mysql](#module\_mysql) | github.com/Jonathan-Atana/terraform-modules/storage/mysql | v1.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | The password for the MySQL database | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | The username for the MySQL database | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db-address"></a> [db-address](#output\_db-address) | Connect to the MySQL database at this endpoint |
| <a name="output_db-port"></a> [db-port](#output\_db-port) | The port on which the MySQL database is listening/accessible |

---

## Additional Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Terraform Module Registry](https://registry.terraform.io/)
- [Best Practices for Module Development](https://developer.hashicorp.com/terraform/language/modules/develop)

## Authors

- **Author:** Jonathan
- **Generated on:** 2025-06-06
<!-- END_TF_DOCS -->