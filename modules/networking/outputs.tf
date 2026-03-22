output "vpc_id" {
  value = aws_vpc.fintech_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.pub_sub[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.pri_sub[*].id
}
