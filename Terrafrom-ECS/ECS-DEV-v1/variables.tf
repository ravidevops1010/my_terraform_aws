variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "iam_role_name" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "subnet_id" {

}

variable "desired_capacity" {

}

variable "max_size" {

}

variable "min_size" {

}

variable "health_check_grace_period" {
  type    = string
  default = 300
}

variable "associate_public_ip_address" {

}

variable "cluster_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "desired_count" {
  type = string
}

variable "host_path" {

}

variable "cpu" {

}

variable "memory" {

}

variable "container_network" {

}

variable "awslogs-region" {

}

variable "container_path" {

}

variable "container_image" {

}

variable "max_task" {

}

variable "min_task" {

}

variable "target_capacity" {

}


#  variable "container_memory" {}

#  variable "host_port" {}

#  variable "container_port" {}

#  variable "container_cpu" {}

