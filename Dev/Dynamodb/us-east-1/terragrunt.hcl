include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
    source = "git@github.com:mskgh/msk-terraform-modules.git//modules/Dynamodb"

    extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "init",
      "fmt",
      "validate"
    ]
    required_var_files = ["./terraform.tfvars"]
  }
}