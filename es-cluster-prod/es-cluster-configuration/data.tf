data "aws_instance" "ec2" {
  filter {
    name = "tag:Name"
    values = ["${var.server_tag}"]
  }
}