output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
output "ec2_asg_name" {
  value = aws_autoscaling_group.web_asg.name
}
output "rds_mysql_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
output "rds_postgres_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
output "bi_url" {
  value = aws_instance.bi_instance.public_dns
}