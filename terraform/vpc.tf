module "vpc" {
    source = "terraform-aws-module/vpc.aws"
    version = ""

    name = "busha-vpc"

    cidr = "10.0.0.0/16"
    azs = slice(data.aws_availabilty_zones.availability.names, 0, 3)

    public_subnets = ["10.0.0.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

    enable_nat_gateway = true
    sinhgle_nat_gateway = true
    enable_dns_hostname = true


    public_subnet_tags = {
        "kubernetes.io/cluster/${local_cluster_name}" = "shared"
        "kubernetes.io/role/elb" = true
    }

     private_subnet_tags = {
        "kubernetes.io/cluster/${local_cluster_name}" = "shared"
        "kubernetes.io/role/elb" = -1
    }


}