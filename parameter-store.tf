resource "aws_ssm_parameter" "ALB-ASG-Scale-Info" {
#  count     = "${length(data.aws_ssm_parameter.ALB-ASG-Scale-Info.value) > 0 ? 0 : 1}"
  count = "${1 - signum(length(data.aws_ssm_parameter.ALB-ASG-Scale-Info.value))}"
  name      = "ALB-ASG-Scale-Info"
  type      = "String"
  value     = "MinSize:1, MaxSize: 2, DesiredCapacity: 2"
  overwrite = "true"
}
