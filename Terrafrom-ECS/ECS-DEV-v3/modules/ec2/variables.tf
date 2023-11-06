variable "ami" {
    type      = string
}
    
variable "subnet_id" {
  type        = string
}

variable "key_name" {
    type      = string
}

variable "security_group_id" {
  type        = string
}

variable "tags" {
    type       = map(string)
}

variable "instance_type" {}

variable "user_data" {}

variable "public_ip" {}

variable "iam_instance_profile" {}

variable "eip_allocation_id" {
  
}













