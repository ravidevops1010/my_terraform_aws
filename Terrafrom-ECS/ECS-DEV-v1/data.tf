data "aws_iam_instance_profile" "ecs_profile" {
  name = var.iam_role_name
}

data "template_file" "container_definitions" {
  template = file("${path.module}/container_def.json")
  vars = {
    container_name    = "${var.app_name}_container"
    container_network = "${var.container_network}"
    awslogs-group     = "${var.cluster_name}_logs"
    awslogs-region    = "${var.awslogs-region}"
    container_path    = "${var.container_path}"
    source_volume     = "${var.app_name}_volume"
    container_image   = "${var.container_image}"
    # container_cpu       = "${var.container_cpu}"
    # container_memory    = "${var.container_memory}"
    # host_port           = "${var.host_port}"
    # container_port      = "${var.container_port}"
  }

}

data "template_file" "file" {
  template = file("${path.module}/index.html")
}
data "template_cloudinit_config" "ecs_data" {
  gzip          = false
  base64_encode = false
  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo 'ECS_CLUSTER=${var.cluster_name}' >> /etc/ecs/ecs.config
    echo 'ECS_DISABLE_PRIVILEGED=true' >> /etc/ecs/ecs.config
    mkdir /home/ec2-user/html
    EOF
  }
  #second part
  part {
    content_type = "text/cloud-config"
    filename     = "index.html"
    content      = local.cloud_config_config
  }
}