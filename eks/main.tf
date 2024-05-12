data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = var.backend_bucket
    key            = "vpc/aws/${var.environment}/${var.region}/vpc-angi/terraform.tfstate"
    region         = var.region
    encrypt        = true
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access         = true
  cluster_enabled_log_types              = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days = 30

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  vpc_id                   = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids               = data.terraform_remote_state.vpc.outputs.public_subnets
  control_plane_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::437023642520:role/terraform-aws-infra-role"
      username = "terraform-aws-infra-role"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::437023642520:user/prashant.pal"
      username = "prashant.pal"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_accounts = [
    "437023642520",
  ]

  tags = {
    Environment = "dev"
    VPC         = "vpc-angi"
    Terraform   = "true"
  }
}

data "aws_eks_cluster" "cluster" {
  depends_on = [module.eks.cluster_name]
  name  = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  depends_on = [module.eks.cluster_name]
  name  = module.eks.cluster_name
}

provider kubernetes {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}