#  ROLES
output "ec2_ecs_role_arn" {
  value = aws_iam_role.ec2_ecs_role.arn
}

output "ecs_autoscale_role_arn" {
  value = aws_iam_role.ecs_autoscale_role.arn
}

output "ecs_role_arn" {
  value = aws_iam_role.ecs_role.arn
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}