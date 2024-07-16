variable "cluster_name" {
    description = "Name of the cluster"
    type = string
    default = "demo"
}

variable "eks_subnets" {
    description = "Subnets to deploy EKS"
    type = list
    default = []
}
  
variable "node_group_name" {
    description = "Name of the nodegroup"
    type = string
    default = "demo"
}

variable "node_subnets" {
    description = "Subnets to deploy EKS nodegroup"
    type = list
    default = []
}
  
variable "security_groups_id" {

    description = "Security group of the required task."
    type = list
    default = []
  
}
