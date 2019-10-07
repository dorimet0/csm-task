resource "aws_cloudwatch_event_rule" "every_ten_minutes" {
  name = "10_minutes_timer"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "call_switch_policies_every_ten_minutes" {
    rule = "${aws_cloudwatch_event_rule.every_ten_minutes.name}"
    target_id = "${aws_lambda_function.switch_policies.function_name}"
    arn = "${aws_lambda_function.switch_policies.arn}"
}

