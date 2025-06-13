<!-- BEGIN_TF_DOCS -->

# Description

This module is to create an aws iam user

## Usage

To use this configuration, ensure you have the necessary AWS credentials set up and run:

```bash
terraform init
terraform plan
terraform apply
```

---

## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | 5.99.0  |

## Providers

No providers.

## Modules

| Name                                                        | Source                                                 | Version |
| ----------------------------------------------------------- | ------------------------------------------------------ | ------- |
| <a name="module_iam_user"></a> [iam_user](#module_iam_user) | github.com/Jonathan-Atana/terraform-modules/global/iam | v1.1.0  |

## Resources

No resources.

## Inputs

| Name                                                         | Description                        | Type     | Default     | Required |
| ------------------------------------------------------------ | ---------------------------------- | -------- | ----------- | :------: |
| <a name="input_user_name"></a> [user_name](#input_user_name) | The name of the iam user to create | `string` | `"newUser"` |    no    |

## Outputs

| Name                                                                    | Description                 |
| ----------------------------------------------------------------------- | --------------------------- |
| <a name="output_iam-user-arn"></a> [iam-user-arn](#output_iam-user-arn) | The ARN of the created user |

---

## Additional Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Terraform Module Registry](https://registry.terraform.io/)
- [Best Practices for Module Development](https://developer.hashicorp.com/terraform/language/modules/develop)

## Authors

- **Author:** Jonathan
- **Generated on:** 2025-06-13
<!-- END_TF_DOCS -->
