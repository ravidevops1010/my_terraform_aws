resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.family_name
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
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.desired_count
  
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  lifecycle {
    ignore_changes = [desired_count]
  }  
}