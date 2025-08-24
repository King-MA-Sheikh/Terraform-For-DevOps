module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                                = local.name
  kubernetes_version                  = "1.30"   # <-- Here’s the key change
  endpoint_public_access              = true
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  addons = {
    vpc-cni    = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    coredns    = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    terra-cluster-ng = {
      instance_types                        = ["t3.medium"]
      attach_cluster_primary_security_group = true
      min_size       = 2
      max_size       = 3
      desired_size   = 2
      capacity_type  = "SPOT"
    }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}