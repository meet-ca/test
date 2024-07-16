#### Output #####
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "privat_subnets_id" {
  description = "The ID of the private subnet"
  value   =    [aws_subnet.private1.id, aws_subnet.private2.id]
}
  