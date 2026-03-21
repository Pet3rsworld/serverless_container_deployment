output "vpc_id" {
  value = aws_vpc.fintech_vpc.id
}

output "public_subnets" {
  value = aws_subnet.pub_sub[*].id
}

output "private_subnets" {
  value = aws_subnet.pri_sub[*].id
}
