module "auto_scalling" {

  source                        = "./Modules/asg-with-lt"
  ami_id                        = var.ami_id
  instance_type                 = var.instance_type
  key_name                      = var.key_name
  security_group_id             = var.security_group_id
  subnet_id                     = var.subnet_id   
  volume_size                   = var.volume_size
  availability_zone             = var.availability_zone
  app_name                      = var.app_name
  desired_capacity              = var.desired_capacity
  max_size                      = var.max_size
  min_size                      = var.min_size
  target_group_arn              = var.target_group_arn  
  cooldown                      = var.cooldown
  scale_up_threshold            = var.scale_up_threshold
  scale_down_threshold          = var.scale_down_threshold
  user_data                     = "${base64encode(<<EOF
                                    #!/bin/bash
                                    aws ec2 associate-address --instance-id $(curl http://169.254.169.254/latest/meta-data/instance-id) --public-ip ${var.elastic_ip}
                                    EOF
                                   )}"
}
