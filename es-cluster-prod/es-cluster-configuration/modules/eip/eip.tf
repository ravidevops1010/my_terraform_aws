resource "aws_eip_association" "eip_assoc" {
  instance_id   = var.instance_id
  allocation_id = var.eip_allocation_id
}