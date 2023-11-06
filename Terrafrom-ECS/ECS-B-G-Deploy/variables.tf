variable "ec2_count" {}

variable "ami_id" {}

variable "instance_type" {}

variable "key_name" {}

variable "security_group_id" {}

variable "subnet_id" {}

variable "associate_public_ip" {}

variable "eip_allocation_id" {}



#################################################

variable "cluster_name" {}

variable "app1_name" {}

#variable "app2_name" {}

variable "desired_count" {}

variable "cpu" {}

variable "memory" {}

#################################################

# variable "container_network" {}

# variable "awslogs-region" {}

# variable "container_path" {}

# variable "container_image" {}

# variable "container_memory" {}

#  variable "container_port" {}

#  variable "container_cpu" {}

#################################################

variable "iam_role_name" {}

variable "service_role_arn" {}

variable "target_group_blue_name" {}

variable "target_group_green_name" {}

variable "target_group_arn" {}

variable "alb_listener_arn" {}

variable "container_name" {}

variable "container_port" {}

variable "host_path" {}
