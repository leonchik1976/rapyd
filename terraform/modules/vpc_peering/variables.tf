variable "requester_vpc_id" {
  type = string
}

variable "accepter_vpc_id" {
  type = string
}

variable "requester_vpc_name" {
  type = string
}

variable "accepter_vpc_name" {
  type = string
}

variable "requester_route_table_id" {
  type = string
}

variable "requester_cidr_block" {
  type = string
}

variable "accepter_cidr_block" {
  type = string
}

variable "accepter_route_table_id" {
  type = string
}

variable "node_security_group_id" {
  type = string
}

variable "port" {
  type = number
}