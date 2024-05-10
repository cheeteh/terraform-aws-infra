data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket         = var.backend_bucket
    key            = "eks/aws/${var.environment}/${var.region}/eks-angi/terraform.tfstate"
    region         = var.region
    encrypt        = true
  }
}

provider "flux" {
  kubernetes = {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = data.terraform_remote_state.eks.outputs.cluster_ca_certificate
    token                  = data.terraform_remote_state.eks.outputs.cluster_auth_token
  }
  git = {
    url = "ssh://git@github.com/${var.github_org}/${var.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]

  path = "clusters/my-cluster"
}