resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.requester_vpc_id
  peer_vpc_id = var.accepter_vpc_id
  auto_accept = true

  tags = {
    Name = "${var.requester_vpc_name} and ${var.accepter_vpc_name}"
  }
}

resource "aws_route" "requester_to_accepter" {
  route_table_id            = var.requester_route_table_id
  destination_cidr_block    = var.accepter_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "accepter_to_requester" {
  route_table_id            = var.accepter_route_table_id
  destination_cidr_block    = var.requester_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_security_group_rule" "allow_all_from_requester" {
  security_group_id = var.node_security_group_id
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "-1"
  cidr_blocks       = [var.requester_cidr_block]
  description       = "Allow all traffic from ${var.requester_cidr_block}"
}