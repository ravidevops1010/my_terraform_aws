resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name 

  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]
    provisioner "local-exec" {
    when    = destroy
    command = "aws ecs put-cluster-capacity-providers --cluster ${self.name} --capacity-providers [] --default-capacity-provider-strategy []"
 }

   provisioner "local-exec" {
    when    = destroy
    command = "aws autoscaling update-auto-scaling-group --auto-scaling-group-name spoonbill-dev-asg --min-size 0 --desired-capacity 0"
  }

}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = "capacity_provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = var.auto_scaling_group_arn
    managed_termination_protection = "DISABLED" 
    managed_scaling {
      maximum_scaling_step_size = var.max_task
      minimum_scaling_step_size = var.min_task
      status                    = "ENABLED"
      target_capacity           = var.target_capacity
    }    
  }
  
}

resource "aws_ecs_task_definition" "task_definition" {
  family                    = var.family_name
  container_definitions    = var.container_definition
  cpu                      = var.cpu
  memory                   = var.memory
  volume {
    name      = var.volume_name
    host_path = var.host_path
  }

}

resource "aws_ecs_service" "service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.desired_count
  
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = var.cloudwatch_log_group_name    
}