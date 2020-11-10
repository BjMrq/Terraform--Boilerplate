resource "aws_appautoscaling_target" "ecsAutoScalingTarget" {
  max_capacity = 3
  min_capacity = 1
  resource_id = "service/${var.ecsClusterName}/${var.serviceName}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"

  depends_on = [aws_ecs_service.ecsService]
}

resource "aws_appautoscaling_policy" "ecsAutoScalingPolicy" {
  name = "${var.serviceName}ecsAutoScalingPolicy"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.ecsAutoScalingTarget.resource_id
  scalable_dimension = aws_appautoscaling_target.ecsAutoScalingTarget.scalable_dimension
  service_namespace = aws_appautoscaling_target.ecsAutoScalingTarget.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}