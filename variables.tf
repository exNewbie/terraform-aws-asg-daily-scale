data "aws_ssm_parameter" "ALB-ASG-Scale-Info" {
  name = "ALB-ASG-Scale-Info"
}

variable "asg_name" {
  type        = "string"
  description = "Name of Auto Scaling Group"
}
