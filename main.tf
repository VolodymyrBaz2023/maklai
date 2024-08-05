terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

locals {
  buckets = [
    "sales-data-bucket-wasabi",
    "marketing-data-bucket-wasabi",
    "finance-data-bucket-wasabi",
    "engineering-data-bucket-wasabi",
    "operations-data-bucket-wasabi",
  ]

  users = {
    alice = {
      "sales-data-bucket-wasabi"       = "rw",
      "marketing-data-bucket-wasabi"   = "rw",
      "engineering-data-bucket-wasabi" = "ro"
    }
    bob = {
      "sales-data-bucket-wasabi"       = "rw",
      "marketing-data-bucket-wasabi"   = "rw",
      "engineering-data-bucket-wasabi" = "rw",
      "finance-data-bucket-wasabi"     = "rw",
      "operations-data-bucket-wasabi"  = "rw"
    }
    charlie = {
      "operations-data-bucket-wasabi" = "rw",
      "finance-data-bucket-wasabi"    = "ro"
    }
    backup = {
      "sales-data-bucket-wasabi"       = "ro",
      "marketing-data-bucket-wasabi"   = "ro",
      "engineering-data-bucket-wasabi" = "ro",
      "finance-data-bucket-wasabi"     = "ro",
      "operations-data-bucket-wasabi"  = "ro"
    }
  }

  user_policy_map = flatten([
    for user, policies in local.users : [
      for bucket, permission in policies : {
        user       = user
        bucket     = bucket
        permission = permission
      }
    ]
  ])
}





