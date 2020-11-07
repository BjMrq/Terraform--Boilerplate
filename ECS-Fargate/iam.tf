resource "aws_iam_role" "ec2EcsRole" {
  name        = "${var.ecsClusterName}-Ec2EcsRole"
  description = "Allows EC2 instances in an ECS cluster to access ECS"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    name = "ec2-ecs-role"
  }
}

resource "aws_iam_role_policy" "ec2EcsPolicy" {
  name = "ec2EcsPolicy"
  role = aws_iam_role.ec2EcsRole.id


  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeTags",
                "ecs:CreateCluster",
                "ecs:DeregisterContainerInstance",
                "ecs:DiscoverPollEndpoint",
                "ecs:Poll",
                "ecs:RegisterContainerInstance",
                "ecs:StartTelemetrySession",
                "ecs:UpdateContainerInstancesState",
                "ecs:Submit*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "ecsAutoscaleRole" {
  name        = "${var.ecsClusterName}-EcsAutoScaleRole"
  description = "Allows Auto Scaling to access and update ECS services"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    name = "ec2-ecs-role"
  }
}

resource "aws_iam_role_policy" "ecsAutoscalePolicy" {
  name = "ecsAutoScalePolicy"
  role = aws_iam_role.ecsAutoscaleRole.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:DescribeServices",
        "ecs:UpdateService"
        ],
      "Resource": [
            "*"
        ]
    },
    {
      "Effect": "Allow",
      "Action": [
          "cloudwatch:DescribeAlarms",
          "cloudwatch:PutMetricAlarm"
      ],
      "Resource": [
          "*"
      ]
    }
]
}
EOF
}


resource "aws_iam_role" "ecsRole" {
  name        = "${var.ecsClusterName}-ecsRole"
  description = "Allows ECS to create and manage AWS resources"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    name = "ecs-role"
  }
}

resource "aws_iam_role_policy" "ecsPolicy" {
  name = "ecsPolicy"
  role = aws_iam_role.ecsRole.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
              "ec2:AuthorizeSecurityGroupIngress",
              "ec2:Describe*",
              "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
              "elasticloadbalancing:DeregisterTargets",
              "elasticloadbalancing:Describe*",
              "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
              "elasticloadbalancing:RegisterTargets"
          ],
          "Resource": "*"
      }
  ]
}
EOF
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name        = "${var.ecsClusterName}-EcsTaskExecutionRole"
  description = "Allows ECS to create and manage AWS resources"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    name = "ecs-task-execution-role"
  }
}

resource "aws_iam_role_policy" "ecsTaskExecutionPolicy" {
  name = "ecsTaskExecutionPolicy"
  role = aws_iam_role.ecsTaskExecutionRole.id


  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
