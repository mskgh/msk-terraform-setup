msk-dynamodb-table = {
  table_name            = "msk-users-table"
  billing_mode          = "PROVISIONED"
  read_capacity         = 20
  write_capacity        = 20
  hash_key              = "UserId"
  range_key             = "AccountId"
  enable_time_to_exists = true
}

tags = {
  Name = "MSK Users Table"
}