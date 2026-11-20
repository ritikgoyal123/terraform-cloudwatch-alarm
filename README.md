Terraform CloudWatch Alarm Project
Overview
This project demonstrates monitoring an Amazon EC2 instance using AWS CloudWatch and Terraform.

Resources Created
EC2 Instance
Security Group
CloudWatch Alarm
Alarm Configuration
Metric: CPUUtilization
Threshold: 1%
Evaluation Period: 1 minute
Deployment Commands
terraform init terraform plan terraform apply

Result
CloudWatch alarm changes to "In alarm" when CPU usage exceeds the configured threshold.
