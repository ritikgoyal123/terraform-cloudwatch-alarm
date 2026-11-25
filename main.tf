provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "monitor" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "project3-monitor"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "ritik-project3-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 1

  dimensions = {
    InstanceId = aws_instance.monitor.id
  }

  alarm_description = "CPU exceeds 20%"
}
