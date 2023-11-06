
module "instance" {
  source                    = "./modules/ec2"
  count                     = var.ec2_count
  ami                       = var.ami_id
  instance_type             = var.instance_type
  subnet_id                 = var.subnet_id
  key_name                  = var.key_name
  security_group_id         = var.security_group_id
  iam_instance_profile      = data.aws_iam_instance_profile.ecs_profile.name
  public_ip                 = var.associate_public_ip
  eip_allocation_id         = var.eip_allocation_id
  tags                      = {
      Name                  = "EC2-${var.cluster_name}"  
  } 
  user_data                 = data.template_cloudinit_config.ecs_data.rendered
}


module "ecs" {
  source                    = "./modules/ecs"
  cluster_name              = var.cluster_name
  depends_on                = [module.instance]
}


module "ecs_task" {
  source                    = "./modules/ecs_task"
  for_each                  = tomap(local.ecs_task)
  family_name               = each.value.family_name
  volume_name               = each.value.volume_name
  ecs_service_name          = each.value.ecs_service_name
  host_path                 = each.value.host_path 
  desired_count             = var.desired_count
  cpu                       = var.cpu
  memory                    = var.memory
  ecs_cluster_id            = module.ecs.ecs_cluster_output.id
  container_definition      = each.value.container_definition
  depends_on                = [module.instance]
}
