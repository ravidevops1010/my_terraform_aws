ami_id                              =  "ami-05fa00d4c63e32376"
instance_type                       =  "t2.small"
key_name                            =  "asg-test"
subnet_id                           =  "subnet-054327b091e0adc75"
security_group_id                   =  "sg-057691cfbcea8c39e"
elastic_ip                          =  "34.199.224.26"
volume_size                         =  8
availability_zone                   =  "us-east-1a"
app_name                            =  "myapp"

############################################################################################################################################
desired_capacity                    =  1
max_size                            =  5      # maximum scaling 
min_size                            =  1      # minimum scaling
cooldown                            = "120"
scale_up_threshold                  = "30"
scale_down_threshold                = "10"
target_group_arn                    = "arn:aws:elasticloadbalancing:us-east-1:906448665985:targetgroup/demo-tg/40bfa90eade0761a"



