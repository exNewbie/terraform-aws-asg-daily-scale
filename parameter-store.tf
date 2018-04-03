resource "aws_ssm_parameter" "ALB-ASG-Scale-Info" {
  name  = "ALB-ASG-Scale-Info"
  type  = "String"
  value = "MinSize:1, MaxSize: 2, DesiredCapacity: 2"
  overwrite = "true"
}

