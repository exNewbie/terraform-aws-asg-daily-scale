### Variables ###

variable "asg_name" {
  type        = "string"
  description = "Name of Auto Scaling Group"
}

### Data ###

data "aws_caller_identity" "current" {}
