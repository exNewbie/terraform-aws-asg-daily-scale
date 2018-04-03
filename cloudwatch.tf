## scale up ##
resource "aws_cloudwatch_event_rule" "Daily-ASG-ScaleUp" {
  name                = "Daily-ASG-ScaleUp"
  schedule_expression = "cron(55 09 * * ? *)"
}

resource "aws_cloudwatch_event_target" "Daily-ASG-ScaleUp-Target" {
  rule = "${aws_cloudwatch_event_rule.Daily-ASG-ScaleUp.name}"
  arn  = "${aws_lambda_function.Scale-Up.arn}"

  input = <<EOF
{
  "ParamStore-Name": "${aws_ssm_parameter.ALB-ASG-Scale-Info.name}",
  "ASG-Name": "${var.asg_name}"
}
EOF
}

## scale down ##
resource "aws_cloudwatch_event_rule" "Daily-ASG-ScaleDown" {
  name                = "Daily-ASG-ScaleDown"
  schedule_expression = "cron(00 08 * * ? *)"
}

resource "aws_cloudwatch_event_target" "Daily-ASG-ScaleDown-Target" {
  rule = "${aws_cloudwatch_event_rule.Daily-ASG-ScaleDown.name}"
  arn  = "${aws_lambda_function.Scale-Down.arn}"

  input = <<EOF
{
  "ParamStore-Name": "${aws_ssm_parameter.ALB-ASG-Scale-Info.name}",
  "ASG-Name": "${var.asg_name}"
}
EOF
}
