variable "cluster_name" {
  default = "devops-eks-cluster"
}

variable "region" {
  default = "ap-south-1"
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "desired_capacity" {
  default = 2
}
