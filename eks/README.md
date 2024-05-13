# Terraform Module: [eks]

[![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D%200.12-green.svg)](https://www.terraform.io/downloads.html)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/<your_username>/<repo_name>/blob/main/LICENSE)

## Description
This Terraform module creates a EKS Cluster on AWS.

## Features

- provides a simple way to setup multiple EKS clusters
- provision an EKS cluster with using `eks_managed_node_groups` and specified number of worker nodes.
- set up `aws-auth` for required roles and users for access
- utilizes vpc created under /vpc 
- provides required outputs for other modules

## Usage

#### Multi cluster setup

Create a new file under `terraform_tfvars`.

Here is an example of `sample.tfvars`:

```hcl
# Generic Variables
cluster_name = "<cluster-name>"
region = "<region>"
environment = "<prod|dev|staging>"
owners      = "aws"

cluster_version = <cluster version>
backend_bucket = "backend S3 bucket name"
```

Corresponding backend for storing terraform state under `terraform_tfbackend`

Here is an example of `sample.tfbackend`:

```hcl
bucket         = "backend S3 bucket name"
key            = "path to store tf state"
region         = "region"
```