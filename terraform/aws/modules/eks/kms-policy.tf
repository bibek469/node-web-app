data "aws_iam_policy_document" "kms" {
  statement {
    sid = ""

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ListGrants",
      "kms:DescribeKey"
    ]

    resources = [
      "arn:aws:s3:::*",
      "arn:aws:kms:${var.aws_region}::key:*"
    ]
  }
}