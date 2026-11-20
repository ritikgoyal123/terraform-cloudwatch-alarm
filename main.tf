provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_sg" {
  name = "cloudwatch-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "monitor" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("user-data.sh")

  tags = {
    Name = "CloudWatch-Monitor"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "HighCPUAlarm"
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

  alarm_description = "Alarm when CPU exceeds 10%"
}
