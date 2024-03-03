generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  terraform {
    backend "s3" {
        bucket         = "${get_env("s3Bucket")}"
        key            = "${path_relative_to_include()}/terraform.tfstate"
        region         = "${get_env("regionName")}"
        encrypt        = "${get_env("toEncrypt")}"
        dynamodb_table = "${get_env("dynamodbTable")}"
    }
  }
EOF
}

