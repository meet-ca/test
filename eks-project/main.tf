provider "aws" {
    region = "us-east-1"
}

module "vpc" {
    source = ".//modules/vpc"

    vpc_cidr = "10.0.0.0/16"
    public_subnet_1_cidr = "10.0.1.0/24"
    public_subnet_2_cidr = "10.0.2.0/24"
    private_subnet_1_cidr = "10.0.3.0/24"
    private_subnet_2_cidr = "10.0.4.0/24"
  
}

module "eks" {
    source = ".//modules/eks"
    cluster_name = "Meet-EKS"
    eks_subnets = module.vpc.privat_subnets_id 
    node_group_name = "Eks-Node-Groups"
    node_subnets = module.vpc.privat_subnets_id
    security_groups_id = [aws_security_group.all_worker_mgmt.id]

}

