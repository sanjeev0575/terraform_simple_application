region              = "us-east-1"
vpc_cidr            = "10.0.0.0/16"
vpc_name            = "my-vpc"
availability_zones  = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]

ecr_repository_name  =  "my-app-terraform"