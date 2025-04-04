output "ecs_service_name" {
  value = aws_ecs_service.ecs_service.name
}


output "ecs_service_id" {
  description = "ID of the ECS Service"
  value       = aws_ecs_service.ecs_service.id
}

# autoscale

output "ecs_service_scaling_policy" {
  description = "Auto-scaling policy for ECS service"
  value       = aws_appautoscaling_policy.ecs_scaling_policy.id
}

output "ecs_service_scalable_target" {
  description = "Scalable target for ECS service"
  value       = aws_appautoscaling_target.ecs_target.id
}
