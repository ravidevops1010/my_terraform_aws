module "auto_scalling" {
  source                      = "./modules/auto_scalling"
  asg_name                    = "${var.cluster_name}-asg"
  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  launch_config_name          = "${var.cluster_name}_launch_config"
  key_name                    = var.key_name
  security_group_id           = var.security_group_id
  iam_instance_profile        = data.aws_iam_instance_profile.ecs_profile.name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  desired_capacity            = var.desired_capacity
  max_size                    = var.max_size
  min_size                    = var.min_size
  health_check_grace_period   = var.health_check_grace_period
  user_data                   = data.template_cloudinit_config.ecs_data.rendered
  ec2_name                    = "${var.cluster_name}_Instance"
}


module "ecs" {
  source                    = "./modules/ecs"
  cluster_name              = var.cluster_name
  family_name               = "${var.app_name}_task_definition"
  container_definition      = data.template_file.container_definitions.rendered
  auto_scaling_group_arn    = module.auto_scalling.asg_output.arn
  volume_name               = "${var.app_name}_volume"
  host_path                 = var.host_path
  ecs_service_name          = "${var.app_name}_service"
  desired_count             = var.desired_count
  cpu                       = var.cpu
  memory                    = var.memory
  max_task                  = var.max_task
  min_task                  = var.min_task
  target_capacity           = var.target_capacity
  cloudwatch_log_group_name = "${var.cluster_name}_logs"

}


