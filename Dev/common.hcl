
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  terraform {
    backend "s3" {
        bucket         = "terraform-state-file-10num"
        key            = "${path_relative_to_include()}/terraform.tfstate"
        region         = "us-east-1"
        encrypt        = true
        dynamodb_table = "kpXUwRVx1s4HMkJ5vPi8-test-table"
    }
  }
EOF
}