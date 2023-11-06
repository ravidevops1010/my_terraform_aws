#!/bin/bash
AWS_ECS_CONTAINER_INSTANCE_ARN=$(aws ecs list-container-instances \
--cluster ${self.name} \
--query 'containerInstanceArns' \
--output text) &&
aws ecs deregister-container-instance --cluster ${self.name} --container-instance $AWS_ECS_CONTAINER_INSTANCE_ARN --force 
