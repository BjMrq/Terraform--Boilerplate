resource "aws_ecs_cluster" "production-fargate-cluster" {
  name = "${var.ecsClusterName}FargateCluster"
}

data "template_file" "backendTaskDefinitionTemplate" {
  template = file("task_definition.json")

  vars = {
    taskDefinitionName  = var.taskDefinitionName
    ecsServiceName      = var.ecsServiceName
    dockerImageUrl      = var.dockerImageUrl
    memory              = var.memory
    dockerContainerPort = var.dockerContainerPort
    region              = var.region
    repositoryCredentials = var.repositoryCredentials
  }
}

resource "aws_ecs_task_definition" "backendTaskDefinition" {
  family                   = var.taskDefinitionName
  
  container_definitions    = data.template_file.backendTaskDefinitionTemplate.rendered
  
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.fargateIamRole.arn
  task_role_arn            = aws_iam_role.fargateIamRole.arn
}