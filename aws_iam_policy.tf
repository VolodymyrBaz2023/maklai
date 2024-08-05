resource "aws_iam_policy" "user_policies" {
  for_each = { for i, policy in local.user_policy_map : "${policy.user}-${policy.bucket}" => policy }

  name        = "${each.value.user}-${each.value.bucket}-${each.value.permission}-policy"
  description = "Policy for ${each.value.user} on ${each.value.bucket}"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = each.value.permission == "rw" ? ["s3:*"] : ["s3:GetObject", "s3:ListBucket"],
        Resource = [
          "arn:aws:s3:::${each.value.bucket}",
          "arn:aws:s3:::${each.value.bucket}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "user_policy_attachments" {
  for_each = { for i, policy in local.user_policy_map : "${policy.user}-${policy.bucket}" => policy }

  user       = aws_iam_user.users[each.value.user].name
  policy_arn = aws_iam_policy.user_policies[each.key].arn
}
