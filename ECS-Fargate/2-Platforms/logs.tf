
resource "aws_cloudwatch_log_group" "ecsServiceLogGroup" {
  name = "${var.serviceName}-LogGroup"
}