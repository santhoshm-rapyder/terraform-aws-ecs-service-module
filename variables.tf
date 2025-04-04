variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "cluster_id" {
  description = "ECS cluster ID"
  type        = string
}

variable "task_definition_arn" {
  description = "ECS task definition ARN"
  type        = string
}

variable "desired_count" {
  description = "Number of instances of the task to run"
  type        = number
  default     = 1
}

variable "private_subnet_ids" {
  description = "List of private subnets for the service"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for the ECS service"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group for the load balancer"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_port" {
  description = "Port of the container"
  type        = number
}

variable "service_connect_namespace" {
  description = "The Cloud Map namespace for Service Connect"
  type        = string
}


#Autoscale

variable "min_task_count" {
  description = "Minimum number of ECS tasks"
  type        = number
  default     = 1
}

variable "max_task_count" {
  description = "Maximum number of ECS tasks"
  type        = number
  default     = 5
}

variable "target_cpu_utilization" {
  description = "Target CPU utilization percentage for auto-scaling"
  type        = number
  default     = 50
}

variable "scale_in_cooldown" {
  description = "Cooldown period before scaling in (seconds)"
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "Cooldown period before scaling out (seconds)"
  type        = number
  default     = 300
}

variable "health_check_path" {
  description = "Health check path for the target group"
  type        = string
  default     = "/"
}

variable "path_pattern" {
  description = "Path pattern for ALB listener rule"
  type        = string
  default     = "/*"
}
