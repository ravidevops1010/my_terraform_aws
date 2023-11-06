resource "aws_launch_configuration" "ec2" {
  image_id                      = var.ami_id
  instance_type                 = var.instance_type
  name                          = var.launch_config_name
  user_data                     = var.user_data
  key_name                      = var.key_name
  iam_instance_profile          = var.iam_instance_profile
  security_groups               = [var.security_group_id]
  associate_public_ip_address   = var.associate_public_ip_address
   
}

resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  vpc_zone_identifier       = [var.subnet_id]
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  launch_configuration      = aws_launch_configuration.ec2.name
  force_delete              = true
  tag {
    key = "Name"
    value = var.ec2_name
    propagate_at_launch = true
  }
    provisioner "local-exec" {
    when    = destroy
    command = "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${self.name} --min-size 0 --desired-capacity 0"
  }
   

}

output "asg_output" {
    value = aws_autoscaling_group.asg
  }








