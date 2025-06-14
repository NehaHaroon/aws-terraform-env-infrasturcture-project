output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "rds_mysql_endpoint" {
  value = aws_db_instance.mysql.address
}

output "rds_postgres_endpoint" {
  value = aws_db_instance.postgres.address
}