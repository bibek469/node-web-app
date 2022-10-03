# data "aws_iam_policy_document" "kms" {
#   statement {
#     sid = ""

#     actions = [
#       "kms:Encrypt",
#       "kms:Decrypt",
#       "kms:ListGrants",
#       "kms:DescribeKey"
#     ]

#     resources = ["*"]
#   }
# }


# data "aws_iam_policy_document" "kms" {
#   statement {
#     effect = "Allow"
#     principals {
#       identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
#       type = "AWS"
#     }
#     actions = [
#       "kms:Encrypt",
#       "kms:Decrypt",
#       "kms:ListGrants",
#       "kms:DescribeKey"
#     ]
#     resources = ["*"]
#   }
# }
