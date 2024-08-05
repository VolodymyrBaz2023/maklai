
locals {
  user_buckets = {
    for user, policies in local.users :
    user => {
      read  = [for bucket, perm in policies : bucket if perm == "ro"]
      write = [for bucket, perm in policies : bucket if perm == "rw"]
    }
  }
}

output "bucket_names" {
  value = keys(aws_s3_bucket.buckets)
}

output "user_names" {
  value = keys(aws_iam_user.users)
}

output "user_buckets" {
  value = local.user_buckets
}
