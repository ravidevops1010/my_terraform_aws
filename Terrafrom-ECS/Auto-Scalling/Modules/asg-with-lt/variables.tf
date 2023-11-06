variable "ami_id" { }

variable "instance_type" { }

variable "key_name" { }

variable "security_group_id" {
    type  =  string 
 }

 
variable "subnet_id" {
    type  =  string 
 }
 
variable "volume_size" { }

variable "availability_zone" { }

variable "user_data" { }

variable "app_name" { }

variable "desired_capacity" { }

variable "max_size" { }

variable "min_size" { }

variable "target_group_arn" {} 

variable "cooldown" {}

variable "scale_up_threshold" { }

variable "scale_down_threshold" { }




