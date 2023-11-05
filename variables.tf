variable "component" {}
variable "env" {}
variable "engine" {}
variable "engine_version" {}
variable "subnet_ids" {}
variable "vpc_id" {}
variable "port" {
  default = 6379
}
variable "sg_subnet_cidr" {}
variable "node_type" {}
variable "parameter_group_name" {}
variable "kms_key_arn" {}
variable "num_node_groups" {}
variable "replicas_per_node_group" {}