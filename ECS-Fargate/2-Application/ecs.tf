resource "aws_ecs_cluster" "fargateCluster" {
  name = "${var.ecsClusterName}FargateCluster"
}

data "template_file" "taskDefinitionTemplate" {
  template = file("task-template/task_definition.json")

  vars = {
    taskDefinitionName      = var.taskDefinitionName
    serviceName             = var.serviceName
    dockerImage             = var.dockerImage
    dockerContainerPort     = var.dockerContainerPort
    region                  = var.region
    repositoryAuthSecretArn = data.terraform_remote_state.infrastructure.outputs.dockerAuthArn
    environmentVariables    = jsonencode(var.environmentVariables)
  }
}

resource "aws_ecs_task_definition" "taskDefinition" {
  family = var.taskDefinitionName

  container_definitions = data.template_file.taskDefinitionTemplate.rendered

  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = data.terraform_remote_state.infrastructure.outputs.fargateRoleArn
  task_role_arn            = data.terraform_remote_state.infrastructure.outputs.fargateRoleArn
}

resource "aws_ecs_service" "ecsService" {
  name = var.serviceName

  cluster = aws_ecs_cluster.fargateCluster.id

  # If there is already a cluster use this instead
  # cluster         = data.terraform_remote_state.infrastructure.outputs.ecsClusterName

  task_definition = aws_ecs_task_definition.taskDefinition.arn
  desired_count   = var.taskNumber
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.serviceSecurityGroup.id]
    subnets          = [data.terraform_remote_state.infrastructure.outputs.subnetDefaultAz1]
    assign_public_ip = true
  }

  load_balancer {
    container_name   = var.taskDefinitionName
    container_port   = var.dockerContainerPort
    target_group_arn = aws_alb_target_group.ecsBackendTargetGroup.arn
  }
}

resource "aws_cloudwatch_log_group" "ecsServiceLogGroup" {
  name = "${var.serviceName}-LogGroup"
}
