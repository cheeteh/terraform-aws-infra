variable "github_token" {
  sensitive = true
  type      = string
}

variable "github_org" {
  type = string
}

variable "github_repository" {
  type = string
}

# terraforn-aws-eks variables
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
}

variable "region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = ""
}

variable "backend_bucket" {
  description = "Backend bucket "
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = ""
}

variable "create" {
  description = "create cluster"
  type    = bool
  default = true
}
