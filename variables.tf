### Variables ###

variable "asg_name" {
  type        = "string"
  description = "Name of Auto Scaling Group"
}

### Data ###

data "aws_caller_identity" "current" {}

/*
data "aws_ssm_parameter" "ALB-ASG-Scale-Info" {
  name = "ALB-ASG-Scale-Info"
}
*/

