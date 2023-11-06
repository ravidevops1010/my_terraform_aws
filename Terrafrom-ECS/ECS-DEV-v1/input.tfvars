#################### EC2 Details ###################
ami_id                      = "ami-040d909ea4e56f8f3"
instance_type               = "t3.medium"
key_name                    = "testserver"
security_group_id           = "sg-0890ef3a3242f01cd"
subnet_id                   = "subnet-054327b091e0adc75"
associate_public_ip_address = "true"            # "true" or "false"
iam_role_name               = "ecsInstanceRole" # iam role for ecs

#################### Auto Scalling Group Requirements ###################

desired_capacity          = "1"
max_size                  = "1"
min_size                  = "0"
health_check_grace_period = "0"
max_task                  = "1"
min_task                  = "1"
target_capacity           = "1"

#################### ecs, container, service - details ###################
cluster_name      = "spoonbill-dev"
app_name          = "unified"
host_path         = "/home/ec2-user/html/index.html" # volume moutn path to container
desired_count     = "1"
cpu               = "1024"
container_cpu     = "512"
memory            = "2048"
container_image   = "public.ecr.aws/k2j0g0k6/nginx:latest"
container_network = "bridge"
awslogs-region    = "us-east-1"
container_path    = "/usr/share/nginx/html/index.html"


#### for host port & container port etc deatails check container.json file#####################

# container_cpu       = ""
# container_memory    = ""
# host_port           = ""
# container_port      = ""


