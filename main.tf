resource "aws_ecs_service" "ecs_service" {
  name            = "${var.environment}-ecs-service"
  cluster        = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = "EC2"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.security_group_id]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  service_connect_configuration {
    enabled = true
    namespace = var.service_connect_namespace

    service {
      discovery_name  = var.container_name
      client_alias {
        dns_name = var.container_name
        port     = var.container_port
      }
      port_name = "service-connect"
    }
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}


# Auto Scaling Target
resource "aws_appautoscaling_target" "ecs_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_id}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_task_count
  max_capacity       = var.max_task_count
}

# Auto Scaling Policy (Target Tracking)
resource "aws_appautoscaling_policy" "ecs_scaling_policy" {
  name               = "${var.environment}-ecs-scaling-policy"
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = var.target_cpu_utilization
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}
