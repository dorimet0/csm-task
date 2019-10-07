data "aws_iam_policy" "AdminAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy" "Billing" {
  arn = "arn:aws:iam::aws:policy/job-function/Billing"
}


resource "aws_iam_role" "Engineering" {
  name = "Engineering"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com" ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "Finance" {
  name = "Finance"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com" ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "engineering-role-policy-attach" {
  role = aws_iam_role.Engineering.name
  policy_arn = data.aws_iam_policy.AdminAccess.arn
}

resource "aws_iam_role_policy_attachment" "finance-role-policy-attach" {
  role = aws_iam_role.Finance.name
  policy_arn = data.aws_iam_policy.Billing.arn
}