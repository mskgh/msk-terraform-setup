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
  }
}

inputs = {
  msk-dynamodb-table = {
    table_name            = "msk-${basename(dirname(dirname(get_terragrunt_dir())))}-${basename(dirname(dirname(dirname(get_terragrunt_dir()))))}-client-login-tb"
    billing_mode          = "PROVISIONED"
    read_capacity         = 20
    write_capacity        = 20
    hash_key              = "TernantId1"
    range_key             = "TernantId2"
    enable_time_to_exists = true
  }
  
  msk-dynamodb-table-attributes = [
    {"name"="TernantId1", "type"="S"},
    {"name"="TernantId2", "type"="S"}
  ]

  tags = {
    "Table Name"    = "msk-${basename(dirname(dirname(get_terragrunt_dir())))}-${basename(dirname(dirname(dirname(get_terragrunt_dir()))))}-client-login-tb"
    Environment     = "${basename(dirname(dirname(dirname(get_terragrunt_dir()))))}"
    Region          = "${basename(dirname(dirname(get_terragrunt_dir())))}"
  }
}

