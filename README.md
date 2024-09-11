<!-- Space: DCG -->
<!-- Parent: Devoteam A Cloud Germany -->
<!-- Parent: Tech Documentation -->
<!-- Title: Devoteam Terraform Modules Repository -->

<!-- Include: ./disclaimer.md -->

# Devoteam Terraform Modules Repository

Welcome to the Terraform Modules repository! This repository serves as a centralized hub for storing and managing reusable Terraform Modules.

## Purpose

The purpose of this repository is to provide a single location for storing and sharing common Terraform Modules that can be easily reused across multiple projects within Devoteam organization. By centralizing these resources, you can promote code reuse, maintain consistency, and simplify the management of Terraform Modules across your projects.

## Repository Structure

The repository is organized as follows:

- `./`: Contains reusable Terraform Modules that can be referenced from other repositories.

## Usage

Terraform will recognize unprefixed github.com URLs and interpret them automatically as Git repository sources.
```
module "example" {
  source = "github.com/devoteam/terraform-modules/example"
}
```

The above address scheme will clone over HTTPS. To clone over SSH, use the following form:
```
module "example" {
  source = "git@github.com:devoteam/terraform-modules.git/example"
}

```


## Resources
| Type   | Name         | Description                         |
|--------|--------------|-------------------------------------|
| Label  | [tf-label](https://github.com/Devoteam/terraform-modules/tree/main/tf-label)        | Terraform module for consistent names and tags generation for resources.  |
| AWS Lambda | [tf-aws-lambda](https://github.com/Devoteam/terraform-modules/tree/main/tf-aws-lambda)        | Terraform module for launching Lambda Functions  |
| AWS Lambda Layer | [tf-aws-lambda-layer](https://github.com/Devoteam/terraform-modules/tree/main/tf-aws-lambda-layer)        | Terraform module for Lambda Functions Layer definition  |
| AWS DynamoDb | [tf-aws-dynamodb](https://github.com/Devoteam/terraform-modules/tree/main/tf-aws-dynamodb)        | Terraform module for DynamoDb table definition  |
| AWS S3 Bucket | [tf-aws-s3-bucket](https://github.com/Devoteam/terraform-modules/tree/main/tf-aws-s3-bucket)        | Terraform module for AWS S3 Bucket definition  |

## Contributing

Contributions to this repository are welcome! If you have any reusable Terraform Module that you would like to share with the organization, please follow these steps:

1. Fork this repository.
2. Create a new branch for your contribution.
3. Add your Terraform Module to the appropriate directory.
4. Update the documentation and README files as necessary.
5. Submit a pull request describing your changes.

Please ensure that your contributions adhere to the repository's coding conventions and best practices.

## Support

If you have any questions, issues, or suggestions related to this repository, please open an issue in the issue tracker. We appreciate your feedback and will do our best to assist you.

## License

This repository is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute the code and resources in this repository as per the terms of the license.

Happy automating with Terraform!