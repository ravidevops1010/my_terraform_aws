
module "instance" {
  source               = "./modules/ec2"
  count                = var.ec2_count
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = var.subnet_id
  key_name             = var.key_name
  security_group_id    = var.security_group_id
  iam_instance_profile = data.aws_iam_instance_profile.ecs_profile.name
  public_ip            = var.associate_public_ip
  eip_allocation_id    = var.eip_allocation_id
  tags = {
    Name = "ECS-${var.cluster_name}"
  }
  user_data = data.template_cloudinit_config.ecs_data.rendered
}


module "ecs" {
  source       = "./modules/ecs"
  cluster_name = var.cluster_name
  depends_on   = [module.instance]
}


module "ecs_task" {
  source               = "./modules/ecs_task"
  for_each             = tomap(local.ecs_task)
  family_name          = each.value.family_name
  cpu                  = var.cpu
  memory               = var.memory  
  container_definition = each.value.container_definition
  ecs_service_name     = each.value.ecs_service_name
  ecs_cluster_id       = module.ecs.ecs_cluster_output.id  
  desired_count        = var.desired_count
  target_group_arn     = var.target_group_arn
  container_name       = var.container_name
  volume_name          = each.value.volume_name
  container_port       = var.container_port 
  host_path            = var.host_path
  depends_on           = [module.ecs]
}


module "ecs_deploy" {
  source                  = "./modules/ecs_deploy"
  for_each                = tomap(local.ecs_task)
  app_name                = var.app1_name
  service_role_arn        = var.service_role_arn
  cluster_name            = module.ecs.ecs_cluster_output.name
  ecs_service_name        = each.value.ecs_service_name
  alb_listener_arn        = var.alb_listener_arn
  target_group_blue_name  = var.target_group_blue_name
  target_group_green_name = var.target_group_green_name  
  depends_on              = [module.ecs_task]
}

