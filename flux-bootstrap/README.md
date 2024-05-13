# Terraform Resource: [flux-bootstrap-git]

[![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D%200.12-green.svg)](https://www.terraform.io/downloads.html)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/<your_username>/<repo_name>/blob/main/LICENSE)

## Description
This Terraform code bootstrap flux on EKS Cluster. It is a better way to setup flux rather than using CLI.

`flux-bootstrap-git` is a tool for bootstrapping Git repositories with Flux for Kubernetes GitOps workflows.

## Overview

This tool automates the process of setting up Git repositories to be managed by Flux, enabling continuous delivery of Kubernetes manifests from version-controlled repositories.

## Features

- supports installation on multiple EKS clusters.
- initializes Git repositories with Flux configuration files.

## Usage

#### Multi cluster setup

Create a new file under `terraform_tfvars`.

Here is an example of `sample.tfvars`:

```hcl
# Generic Variables
name = "flux-angi"
cluster_name = "<cluster-name>"
region = "<region>"
environment = "<prod|dev|staging>"
owners      = "aws"
cluster_version = "<cluster version>"


backend_bucket = "backend S3 bucket name"
github_repository = "git repo name"
github_org = "git org name"

```

Corresponding backend for storing terraform state under `terraform_tfbackend`

Here is an example of `sample.tfbackend`:

```hcl
bucket         = "backend S3 bucket name"
key            = "path to store tf state"
region         = "region"
```