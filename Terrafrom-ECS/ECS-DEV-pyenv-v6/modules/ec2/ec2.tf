resource "aws_instance" "vm" {
  ami                           = var.ami
  instance_type                 = var.instance_type
  subnet_id                     = var.subnet_id
  private_ip                    = var.private_ip
  key_name                      = var.key_name
  vpc_security_group_ids        = [var.security_group_id]
  iam_instance_profile          = var.iam_instance_profile
  associate_public_ip_address   = var.public_ip   
  user_data                     = var.user_data
  tags                          = var.tags
  
  }

  resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.vm.id
  allocation_id = var.eip_allocation_id
}

  output "ec2_output" {
    value = aws_instance.vm
  }








