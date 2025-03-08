resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.vpc_name
    Environment = "project_environment"
    Terraform   = "true"
  }
}



####subnet
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value)
  map_public_ip_on_launch = true
  availability_zone       = each.key
  tags = {
    Name      = "${each.key}_public_subnet"
    Terraform = "true"
  }
}


resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = each.key

  tags = {
    Name      = "${each.key}_private_subnet"
    Terraform = "true"
  }
}


########################IGW###########
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "project_igw"
  }
}

#####################NGW############

#Need to creat Elastec IP to attced to NGW 
resource "aws_eip" "nat_gateway_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "project_igw_eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  depends_on    = [aws_subnet.public_subnets]
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnets["us-east-1a"].id
  tags = {
    Name = "project_nat_gateway"
  }
}











# Database Subnet 

# resource "aws_db_subnet_group" "db_subnet" {
#   name       = "rds-db-subnet"
#   subnet_ids = [aws_subnet.private_subnets["us-east-1a"].id, aws_subnet.private_subnets["us-east-1b"].id]
# }