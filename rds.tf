# MySQL RDS
resource "aws_db_subnet_group" "mysql_subnets" {
  name       = "mysql-subnet-group"
  subnet_ids = var.private_subnets
}
resource "aws_db_instance" "mysql" {
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  name                 = "appdb"
  username             = "admin"
  password             = "P@ssword123"
  allocated_storage    = 20
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.mysql_subnets.name
  publicly_accessible  = false
}

# PostgreSQL RDS
resource "aws_db_subnet_group" "pg_subnets" {
  name       = "pg-subnet-group"
  subnet_ids = var.private_subnets
}
resource "aws_db_instance" "postgres" {
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  name                 = "analytics"
  username             = "admin"
  password             = "P@ssword123"
  allocated_storage    = 20
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.pg_subnets.name
  publicly_accessible  = false
}