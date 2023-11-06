resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name 
  
}
resource "aws_cloudwatch_log_group" "log_group" {
  name = "${aws_ecs_cluster.cluster.name}-logs"    
}

output "ecs_cluster_output" {
    value = aws_ecs_cluster.cluster
  }