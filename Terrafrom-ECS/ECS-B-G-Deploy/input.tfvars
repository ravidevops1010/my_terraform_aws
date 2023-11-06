#################### EC2 Details ###################
ami_id              = "ami-040d909ea4e56f8f3"
instance_type       = "t3.medium"
key_name            = "testserver"
security_group_id   = "sg-0890ef3a3242f01cd"
subnet_id           = "subnet-054327b091e0adc75"
associate_public_ip = "true"            # "true" or "false"
iam_role_name       = "ecsInstanceRole" # iam role for ecs
ec2_count           = 1
eip_allocation_id   = "eipalloc-08d0afb9825760d81"


# #################### Auto Scalling Group Requirements ###################

# desired_capacity          = "1"
# max_size                  = "1"
# min_size                  = "0"
# health_check_grace_period = "0"
# max_task                  = "1"
# min_task                  = "1"
# target_capacity           = "1"

#################### ecs-task-service ###################
cluster_name  = "portal"
app1_name     = "portal"
# app2_name     = "pyenv"
host_path     = "/home/ec2-user/html/index.html"
desired_count = "1"
cpu           = ""
memory        = ""


######################### container definitions #####################
# container_image   = ["public.ecr.aws/k2j0g0k6/nginx:latest", "public.ecr.aws/k2j0g0k6/tomcat"]
# container_network = "bridge"
# awslogs-region    = "us-east-1"
# container_path    = "/usr/share/nginx/html/index.html"
# container_cpu     = 10
# container_memory  = 1024
# host_port         = [ 80, 8080 ]
# container_port    = [ 80, 8080 ]

############################################################

service_role_arn        = "arn:aws:iam::906448665985:role/codedeployroleforECSdeployment"

target_group_arn        =  "arn:aws:elasticloadbalancing:us-east-1:906448665985:targetgroup/portal-tg1/057580a4a3b11439"

target_group_blue_name  = "portal-tg1"

target_group_green_name = "portal-tg2"

alb_listener_arn        = "arn:aws:elasticloadbalancing:us-east-1:906448665985:listener/app/portal/4c07d230d73b9de7/f9fa966c9aa014a8"

container_name          = "portal"

container_port          = "80"
