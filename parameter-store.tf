resource "aws_ssm_parameter" "ALB-ASG-Scale-Info" {
  name  = "ALB-ASG-Scale-Info"
  type  = "String"
  value = ""
  overwrite = "true"
}

