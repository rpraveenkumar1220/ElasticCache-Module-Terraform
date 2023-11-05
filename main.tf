resource "aws_elasticache_subnet_group" "elastic_subnet_group" {
  name       = "${var.component}-${var.env}"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.component}-${var.env}-sbg"
  }
}

##creating security group for Elasticache module
resource "aws_security_group" "SG" {
  name        = "${var.component}-${var.env}-sg"
  description = "${var.component}-${var.env}-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    cidr_blocks      = var.sg_subnet_cidr
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

###creating Elasticache Replication Group
resource "aws_elasticache_replication_group" "replica_group" {
  replication_group_id       = "${var.component}-${var.env}"
  description                = "${var.component}-${var.env}"
  engine                     = var.engine
  engine_version             = var.engine_version
  node_type                  = var.node_type
  port                       = var.port
  parameter_group_name       = var.parameter_group_name
  automatic_failover_enabled = true
  transit_encryption_enabled = true
  kms_key_id                 = var.kms_key_arn
  num_node_groups            = var.num_node_groups
  replicas_per_node_group    = var.replicas_per_node_group
  vpc_security_group_ids     = [ aws_security_group.SG.id]
  subnet_group_name          = aws_elasticache_subnet_group.elastic_subnet_group.name
  skip_final_snapshot        = true
}