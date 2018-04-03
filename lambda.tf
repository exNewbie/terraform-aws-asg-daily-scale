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
  filename         = "Scale-Up.py.zip"
  function_name    = "Scale-Up"
  role             = "${aws_iam_role.Lambda-ASG-Scale.arn}"
  handler          = "Scale-Up.lambda_handler"
  source_code_hash = "${data.archive_file.Scale-Up.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = "300"
}

resource "aws_lambda_function" "Scale-Down" {
  filename         = "Scale-Down.py.zip"
  function_name    = "Scale-Down"
  role             = "${aws_iam_role.Lambda-ASG-Scale.arn}"
  handler          = "Scale-Down.lambda_handler"
  source_code_hash = "${data.archive_file.Scale-Down.output_base64sha256}"
  runtime          = "python3.6"
  timeout          = "300"
}

/* Lambda permits CloudWatch to execute */
/*
resource "aws_lambda_permission" "SSM-Automation-ExecuteEBSBackup-Schedule" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.SSM-Automation-ExecuteEBSBackup.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.DailyEBSBackup.arn}"
}
*/
