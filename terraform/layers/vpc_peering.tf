module "gateway_to_backend_peering" {
  source = "../modules/vpc_peering"

  requester_vpc_id = module.gateway.vpc_id
  accepter_vpc_id = module.backend.vpc_id

  requester_vpc_name = module.gateway.vpc_name
  accepter_vpc_name = module.backend.vpc_name
  
  requester_cidr_block = module.gateway.vpc_cidr
  accepter_cidr_block = module.backend.vpc_cidr
  
  requester_route_table_id = module.gateway.private_route_table_ids[0]
  accepter_route_table_id = module.backend.private_route_table_ids[0]

  node_security_group_id = module.backend.node_security_group_id

  port = 30080
}