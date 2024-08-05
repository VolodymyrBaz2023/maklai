resource "aws_iam_user" "users" {
  for_each = local.users
  name     = each.key
}
