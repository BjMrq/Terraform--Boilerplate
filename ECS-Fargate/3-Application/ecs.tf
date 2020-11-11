resource "aws_ecs_cluster" "fargateCluster" {
  name               = var.ecsClusterName
  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name         = "${var.ecsClusterName}FargateCluster"
    Application  = var.appName
    Environement = var.env
  }
}

locals {
  databaseEnvironement = [{
    name : "DB_HOST",
    value : data.terraform_remote_state.platforms.outputs.dbHost
    },
    {
      name : "DB_PORT",
      value : jsonencode(data.terraform_remote_state.platforms.outputs.dbPort)
    },
    {
      name : "DB_NAME",
      value : data.terraform_remote_state.platforms.outputs.dbName
    },
    {
      name : "DB_USER",
      value : data.terraform_remote_state.platforms.outputs.dbUser
    },
    {
      name : "DB_PASSWORD",
      value : data.terraform_remote_state.platforms.outputs.dbPassword
    }
  ]
}

data "template_file" "taskDefinitionTemplate" {
  template = file("task-template/task_definition.json")


  vars = {
    env                     = var.env
    taskDefinitionName      = var.taskDefinitionName
    serviceName             = var.serviceName
    dockerImage             = var.dockerImage
    dockerContainerPort     = var.dockerContainerPort
    region                  = var.region
    repositoryAuthSecretArn = data.terraform_remote_state.infrastructure.outputs.dockerAuthArn
    environmentVariables    = jsonencode(concat(var.environmentVariables, local.databaseEnvironement))
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

  tags = {
    Application  = var.appName
    Environement = var.env
  }
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
    subnets          = [data.terraform_remote_state.infrastructure.outputs.defaultAz1Id]
    assign_public_ip = true
  }

  load_balancer {
    container_name   = var.taskDefinitionName
    container_port   = var.dockerContainerPort
    target_group_arn = data.terraform_remote_state.platforms.outputs.ALBServiceTargetGroupArn
  }

  tags = {
    Application  = var.appName
    Environement = var.env
  }
}

resource "aws_security_group" "serviceSecurityGroup" {
  name        = "${var.serviceName}SecurityGroup"
  description = "Security for ${var.serviceName} group to communicate in and out"
  vpc_id      = data.terraform_remote_state.infrastructure.outputs.VPCdefaultId

  ingress {
    from_port   = var.dockerContainerPort
    protocol    = "TCP"
    to_port     = var.dockerContainerPort
    cidr_blocks = [data.terraform_remote_state.infrastructure.outputs.VPCdefaultCidr]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.serviceName}SecurityGroup"
  }
}
