output "x" {
  value = aws_vpc.dev_proj_1_vpc_ap_south_1.cidr_block
}

output "y" {
  value = aws_vpc.dev_proj_1_vpc_ap_south_1.id
}

output "z" {
  value = aws_vpc.dev_proj_1_vpc_ap_south_1.region
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}