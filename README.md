# Aws-RDS-MYSQL-Env
This repository provisions an **AWS RDS MySQL database instance** using Terraform, following infrastructure-as-code best practices. It uses:

- Modular Terraform structure
- Remote state in S3 
- GitHub Actions for plan & apply
- Secrets (including DB password) stored securely in GitHub
 
## Prerequisites
 Create an S3 Bucket for Terraform State (AWS Console)
Step 1: Sign In
Go to https://s3.console.aws.amazon.com/s3 and log into your AWS account.

Step 2: Create Bucket
Click [Create bucket].

Fill out the bucket details:

Bucket name: your-terraform-state-bucket (must be globally unique)

AWS Region: Choose the region Terraform will run in (e.g., us-east-1)

Step 3: Configure Options
Leave the following as default:

Object Ownership: Accept "ACLs disabled (recommended)"

Block Public Access: Leave all boxes checked 

Bucket Versioning: Optional (recommended for state tracking)

Encryption: Optional (you can enable SSE-S3 or SSE-KMS for additional security)

Step 4: Create the Bucket
Click [Create bucket] at the bottom.



 ## Project Structure

```
terraform/
  environments/
    dev/
      backend.tf
      main.tf
      variables.tf
      terraform.tfvars
    prod/
      backend.tf
      main.tf
      variables.tf
      terraform.tfvars
  modules/
    mysql/
      main.tf
      outputs.tf
      variables.tf
.github/
  workflows/
    deploy.yml
```

##  Required Secrets in GitHub

In your GitHub repo, go to **Settings → Environments → prod and dev , dev-plan and prod-plan->add Environment secrets** and add:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

INFRACOST_API_KEY  ---copy from infracost.io ->organizations->API Token

MYSQL_ADMIN_PASSWORD  ---you can give any name I gave password123

# Environments
We need to add total four environments that is dev,prod and dev-plan,prod-plan. to avoid manuall reviewer approval for stage branch plan pipeline I used these two envronments(dev-plan and prod-plan) here we are not selecting any reviewer under deployment reviewer.

# Add Collaborators
Go to your repo → Settings → Collaborators

Click "Invite a collaborator"

Enter your teammate’s GitHub username

Choose appropriate access (usually Write or Admin)

Send invite

Note: If you're the owner, you cannot add yourself — you already have full access.

# Add a GitHub Environment

Go to Settings → Environments

Click "New environment", name it dev

Under "Deployment protection rules", click "Required reviewers"

Add your GitHub username (or a teammate)
Click Save

This will enforce manual approval before applying infrastructure.

# Workflow
in deployment.yml file choose the env either dev or prod and dev-plan or prod-plan under plan pipeline
example:
environment: ${{ github.event.inputs.environment ||'dev-plan'}}
env:
      ENV: ${{ github.event.inputs.environment || 'dev' }}

for the Apply pipeline  :
example
 environment: ${{ github.event.inputs.environment || 'dev' }}
    defaults:
      run:
        working-directory: terraform/environments/${{ github.event.inputs.environment || 'dev' }}


 Trigger on stage branch

Automatically runs terraform init, plan, and Infracost report

Skips apply step (for preview only)

 Trigger on main branch (Manual Approval)

Go to Actions → Terraform Azure Psql DB CI/CD → Run workflow

Select the envronment prod or dev

Enter input yes

Waits for approval (based on environment reviewers)

Terraform plan runs

Waits for approval (based on environment reviewers)

Once approved, resources are deployed

# Outputs
db_endpoint
##  Cleanup
```terminal
terraform init
terraform destroy 
```

# References
AWS Rds-Mysql - Terraform Docs

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance