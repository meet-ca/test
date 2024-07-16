output "eks-cluster-name" {
  description = "Name of the cluster"
  value       = aws_eks_cluster.main.name
}

output "eks-node-group_name" {
    description = "Name of the node group"
    value = aws_eks_node_group.main.node_group_name
  
}