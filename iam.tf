/* Lambda Role */

resource "aws_iam_role" "Lambda-ASG-Scale" {
  name = "Lambda-ASG-Scale"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "Update-ParameterStore" {
  name = "Update-ParameterStore"
  role = "${aws_iam_role.Lambda-ASG-Scale.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssm:DescribeParameters",
        "ssm:PutParameter",
        "ssm:GetParameters",
        "ssm:GetParameter",
        "ssm:DeleteParameter"
      ],
      "Resource": "arn:aws:ssm:*:*:parameter/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "Modify-ASGSize" {
  name = "Modify-ASGSize"
  role = "${aws_iam_role.Lambda-ASG-Scale.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:Describe*",
        "autoscaling:UpdateAutoScalingGroup"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
