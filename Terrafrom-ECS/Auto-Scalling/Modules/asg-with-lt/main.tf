resource "aws_launch_template" "lt" {
  name_prefix                   = "launch_template"
  image_id                      = var.ami_id
  instance_type                 = var.instance_type
  key_name                      = var.key_name  
  vpc_security_group_ids        = [var.security_group_id]

  block_device_mappings {
    device_name                 = "/dev/sda1"

    ebs {
      volume_size               = var.volume_size
    }
  }
  placement {
    availability_zone           = var.availability_zone
  }
  monitoring {
    enabled                     = true
  }  
  tag_specifications {
    resource_type               = "instance"

    tags                        = {
      Name                      = "${var.app_name}-server"
    }
}
  user_data                     = var.user_data
}

resource "aws_autoscaling_group" "asg" { 
  vpc_zone_identifier           = [var.subnet_id]
  desired_capacity              = var.desired_capacity
  max_size                      = var.max_size
  min_size                      = var.min_size
  health_check_type             = "EC2"
  target_group_arns             = [var.target_group_arn]


  launch_template {
    id                          = aws_launch_template.lt.id
    version                     = "$Latest"
  }
  # mixed_instances_policy {
  #   instances_distribution {
  #     on_demand_allocation_strategy = "prioritized"
  #     on_demand_base_capacity       = 0
  #     on_demand_percentage_above_base_capacity = 100
  #     spot_allocation_strategy       = "lowest-price"
  #     spot_instance_pools            = 3
  #     spot_max_price                 = "0.2"
  #   }
  # }
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name                        = "${var.app_name}_scale_up_policy"
  policy_type                 = "SimpleScaling"
  adjustment_type             = "ChangeInCapacity"
  scaling_adjustment          = "1"
  autoscaling_group_name      = aws_autoscaling_group.asg.name    
  cooldown                    = var.cooldown
}


resource "aws_cloudwatch_metric_alarm" "scale-up-alarm" {
alarm_name = "${var.app_name}-scale-up-alaram"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "120"
statistic = "Average"
threshold = var.scale_up_threshold
dimensions = {
"AutoScalingGroupName" = aws_autoscaling_group.asg.name
}
actions_enabled = true
alarm_actions = ["${aws_autoscaling_policy.scale_up_policy.arn}"]
}


resource "aws_autoscaling_policy" "scale_down_policy" {
  name                        = "${var.app_name}_scale_down_policy"
  policy_type                 = "SimpleScaling"
  adjustment_type             = "ChangeInCapacity"
  scaling_adjustment          = "-1"
  autoscaling_group_name      = aws_autoscaling_group.asg.name    
  cooldown                    = var.cooldown
}


resource "aws_cloudwatch_metric_alarm" "scale-down-alarm" {
alarm_name = "${var.app_name}-scale-down-alaram"
comparison_operator = "LessThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "120"
statistic = "Average"
threshold = var.scale_down_threshold
dimensions = {
"AutoScalingGroupName" = aws_autoscaling_group.asg.name
}
actions_enabled = true
alarm_actions = ["${aws_autoscaling_policy.scale_down_policy.arn}"]
}

