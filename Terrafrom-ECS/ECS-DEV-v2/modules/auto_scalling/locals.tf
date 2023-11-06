locals {
  cmd1 = "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${var.asg_name} --min-size 0 --desired-capacity 0"  
}