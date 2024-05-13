# ANGI PLATFORM 

Take home project.

## Overview

This project automates the provisioning of mutilple Amazon EKS (Elastic Kubernetes Service) clusters, VPCs (Virtual Private Cloud), and bootstraps Flux for GitOps workflows. It enables continuous delivery of k8s manifests via Github and Helm repositories syncs.


For CI/CD workflows it uses GitHub Actions and have specific workflows for each module.

## Features

- automated provisioning of Amazon EKS clusters and VPCs.
- bootstrapping of Flux for GitOps workflows.
- Synchronize of base infrastrucre configs and controllers.
- CI/CD workflows using GitHub Actions for `terraform plan` on pull request and `terraform apply` on merge to main

## Getting Started

Describing steps taken for this setup:
- create vpc
- create eks
- setup flux bootstrap
- setup helm and git repos for flux sync
- installed tools under infrastructure/config and infrastructure/controller

Manual steps:
- IAM policy and role creation that has necessary permissions
- S3 buckets for storing tf states
- Secrets creation for Mimir

## Usage

- [EKS setup](https://github.com/cheeteh/terraform-aws-infra/blob/main/eks/README.md)
- [VPC setup](https://github.com/cheeteh/terraform-aws-infra/blob/main/vpc/README.md)
- [Flux Bootstrap](https://github.com/cheeteh/terraform-aws-infra/blob/main/flux-bootstrap/README.md)
- [FluxCD](https://github.com/cheeteh/terraform-aws-infra/blob/main/fluxcd/cluster/eks-angi/README.md)
- [Infrastructure Setup](https://github.com/cheeteh/terraform-aws-infra/blob/main/infrastructure/monitoring/README.md)

## Continues Delivery Methodology 

Both FluxCD and ArgoCD adhere to the GitOps methodology, which is a set of practices that emphasize version control and declarative configuration for managing infrastructure and applications. In a GitOps workflow, the desired state of the system is declared in version-controlled Git repositories, and changes to the system are made by modifying these repositories. 

FluxCD takes a Git-centric approach to GitOps, where the primary source of truth for cluster state is the Git repository itself whereas ArgoCD provides a web-based UI approach for managing applications and deployments. 

In this scenario since we are working with multiple cluster and environments, it demands a more automated and Git-Centric approach to handle the source of truth for cluster state and configurations. The added features provided by ArgoCD such has health checks, rollbacks, user interface etc are covered with the observability tools in hand and rollbacks are really easy that are initiated via the source rather than UI which maintains the sanity/checks with other workflows.  

## Improvements

- remove any manuals steps and automate
- allow loki to accept non json format logs
- better code structure and template utilization
- better documentation

