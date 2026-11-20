#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "CloudWatch Monitoring Project" > /var/www/html/index.html
