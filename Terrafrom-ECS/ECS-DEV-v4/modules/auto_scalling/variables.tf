variable "asg_name" {
    type      = string
}

variable "ami_id" {
    type      = string
}
    
variable "instance_type" {
  type        = string
}

variable "launch_config_name" {
    type      = string
}

variable "key_name" {
  type        = string
}

variable "iam_instance_profile" {
    type       = string
}

variable "security_group_id" {
  type        = string
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
    type        = string
    default     = 300
}


variable "user_data" {

}

variable "associate_public_ip_address" {
  
}

variable "ec2_name" {
  
}















