## Lambda raw scripts ###
data "archive_file" "Scale-Up" {
  type        = "zip"
  source_file = "${path.module}/scripts/lambda/Scale-Up.py"
  output_path = "${path.module}/scripts/lambda/Scale-Up.zip"
}

data "archive_file" "Scale-Down" {
  type        = "zip"
  source_file = "${path.module}/scripts/lambda/Scale-Down.py"
  output_path = "${path.module}/scripts/lambda/Scale-Down.zip"
}

### Lambda functions ###

resource "aws_lambda_function" "Scale-Up" {
  filename         = "${data.archive_file.Scale-Up.output_path}"
  function_name    = "Scale-Up"
  role             = "${aws_iam_role.Lambda-ASG-Scale.arn}"
  handler          = "Scale-Up.lambda_handler"
  source_code_hash = "${data.archive_file.Scale-Up.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = "300"
}

resource "aws_lambda_function" "Scale-Down" {
  filename         = "${data.archive_file.Scale-Down.output_path}"
  function_name    = "Scale-Down"
  role             = "${aws_iam_role.Lambda-ASG-Scale.arn}"
  handler          = "Scale-Down.lambda_handler"
  source_code_hash = "${data.archive_file.Scale-Down.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = "300"
}

### Lambda permits CloudWatch to execute ###

resource "aws_lambda_permission" "Daily-ASG-ScaleDown-Permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.Scale-Down.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.Daily-ASG-ScaleDown.arn}"
}

resource "aws_lambda_permission" "Daily-ASG-ScaleUp-Permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.Scale-Up.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.Daily-ASG-ScaleUp.arn}"
}
