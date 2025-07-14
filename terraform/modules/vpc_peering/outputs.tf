output "peering_connection_id" {
  value         = aws_vpc_peering_connection.this.id
  description   = "ID of the VPC Peering Connection"
}