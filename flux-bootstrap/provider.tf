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
}