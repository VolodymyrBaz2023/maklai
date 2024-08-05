resource "aws_s3_bucket" "buckets" {
  for_each = toset(local.buckets)
  bucket   = each.key
}
