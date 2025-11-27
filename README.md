# Strapi CMS Deployment on AWS with Terraform

This Terraform project deploys Strapi CMS on AWS using SQLite, staying within the AWS Free Tier. It uses EC2 and VPC resources only.

## Prerequisites

- AWS CLI configured with your credentials
- Terraform installed (version 1.0 or later)
- SSH key pair created in AWS (replace `key_name` variable with your key pair name)

## Architecture

```
Internet
    |
Internet Gateway
    |
Public Route Table
    |
Public Subnet (10.0.1.0/24)
    |
EC2 Instance (t2.micro)
    |
Strapi Container (Port 1337)
```

## Deployment Steps

1. Clone or download this repository.

2. Navigate to the project directory:
   ```
   cd strapi-terraform
   ```

3. Initialize Terraform:
   ```
   terraform init
   ```

4. Review the plan:
   ```
   terraform plan
   ```

5. Apply the configuration:
   ```
   terraform apply
   ```

6. When prompted, enter your SSH key pair name.

## Accessing Strapi

After deployment, access Strapi at:
```
http://<EC2_PUBLIC_IP>:1337
```

The public IP will be displayed in the Terraform outputs.

## Destroying Resources

To avoid charges, destroy the resources when done:
```
terraform destroy
```

## Files Structure

- `providers.tf`: AWS provider configuration
- `main.tf`: Main configuration calling VPC and EC2 modules
- `variables.tf`: Variable definitions
- `outputs.tf`: Output definitions
- `user-data.sh`: EC2 user data script for Docker and Strapi setup
- `modules/vpc/`: VPC module
- `modules/ec2/`: EC2 module

## Notes

- This deployment uses SQLite for the database, which is suitable for development and small-scale use.
- The EC2 instance is t2.micro, which is within the AWS Free Tier limits.
- Security group allows SSH (port 22) and Strapi (port 1337) from anywhere. In production, restrict these as needed.
