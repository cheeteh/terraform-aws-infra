terraform {
  required_version = ">=1.1.5"

  required_providers {
    flux = {
      source = "fluxcd/flux"
    }
    kubernetes = {
            source = "hashicorp/kubernetes"
            version = "2.3.2"
    }
    kubectl = {
        source  = "gavinbunney/kubectl"
        version = ">= 1.7.0"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }
  }

  backend "s3" {} 

}

provider "aws" {
    region = var.region
}

provider "kubectl" {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_ca_certificate)
    token                  = data.terraform_remote_state.eks.outputs.cluster_auth_token
    load_config_file       = false
}
