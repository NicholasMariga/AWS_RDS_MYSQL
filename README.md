# Project  — Provision Amazon RDS (MySQL)

This project provisions an AWS VPC, a bastion EC2 instance and an Amazon RDS (MySQL) instance using Terraform.
The bastion host runs a MySQL client that you can use to connect to the RDS instance (RDS is deployed in a private subnet).


## Prerequisites
- AWS account with IAM user that can create EC2, RDS, VPC resources.
- Terraform installed (>=1.3).
- AWS CLI configured locally (for manual runs).
- SSH key pair created and uploaded to AWS (key pair name in `terraform.tfvars`).

## Quick start (local)
cd terraform
terraform init

terraform plan -out=tfplan
terraform apply -auto-approve tfplan

terraform output bastion_public_ip
terraform output rds_endpoint

ssh -i ~/.ssh/<your-private-key> ec2-user@$(terraform output -raw bastion_public_ip)

# on bastion
./connect-rds.sh $(terraform output -raw rds_endpoint)
# enter DB password when prompted

cd terraform
terraform destroy -auto-approve



