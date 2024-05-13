# Terraform Module: [eks]

[![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D%200.12-green.svg)](https://www.terraform.io/downloads.html)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/<your_username>/<repo_name>/blob/main/LICENSE)

## Description
This Terraform module creates a Virtual Private Cloud (VPC) on AWS.

## Features

- provides a simple way to setup multiple VPCs 
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


# VPC Variables
name                               = "<vpc-name>" # Overridning the name defined in variable file
cidr                               = "10.0.0.0/16"
azs                                = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets                     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
private_subnets                    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
database_subnets                   = ["10.0.151.0/24", "10.0.152.0/24", "10.0.153.0/24"]
create_database_subnet_group       = true
create_database_subnet_route_table = true
enable_nat_gateway                 = true
single_nat_gateway                 = true
enable_flow_log                    = true
```

Corresponding backend for storing terraform state under `terraform_tfbackend`

Here is an example of `sample.tfbackend`:

```hcl
bucket         = "backend S3 bucket name"
key            = "path to store tf state"
region         = "region"
```