resource "aws_lambda_function" "switch_policies" {
  filename = "func.zip"
  function_name = "switch_policies"
  handler = "lambda_function.lambda_handler"
  role = "${aws_iam_role.iam_for_lambda.arn}"
  runtime = "python3.6"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.switch_policies.function_name}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.every_ten_minutes.arn}"
}

resource "aws_iam_policy" "policy_for_lambda" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:*",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda_attach" {
  name = "lambda_attach"
  roles = [aws_iam_role.iam_for_lambda.name]
  policy_arn =  aws_iam_policy.policy_for_lambda.arn
}