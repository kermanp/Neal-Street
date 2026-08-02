---

## 2. `SOLUTION.md`

```markdown
# Solution Architecture & Design Trade-offs

## 📑 Executive Summary

This project implements an automated, secure, and reproducible cloud infrastructure deployment pipelines. Using **Terraform** for Infrastructure-as-Code (IaC) and **GitHub Actions** for CI/CD, the architecture enforces environment segregation, automated linting/validation, passwordless AWS authentication, and automated speculative plan reviews. 
I created a total of 4 pipelines the first pipleines are for Terraform to provision infrastucutre and the second pipelines were for configuring the instance with anisble.

---

## 🏗️ Architectural Overview

The target architecture provisions a resilient web application footprint inside Amazon Web Services:

Key Components: I configure my terraform into seperate files for cloud reosurces that way if we need to edit anything you can go exactly to the reosurce you wish to configure and make the edit there instead of going through lines of code. I made sure to build everything around using the  Free-tier compliant EC2 instances running non-interactive I picked the OS as Ubuntu 24.04 LTS  as this is what I have the most experince using. 


🔒 Security & Identity Considerations1. Keyless CI/CD Authentication via OIDCRather than storing static, long-lived AWS IAM Access Keys inside GitHub Secrets, the pipeline utilizes OpenID Connect (OIDC) via aws-actions/configure-aws-credentials.Short-lived security tokens are generated per workflow execution.Access is scoped tightly using IAM role trust policies restricted to specific repository branches.2. I used this way so the pipeline is can be repeatably used if needed. I also made use of another best practice which was to seperate AWS accounts having one for PRD and the other for DEv this is a best practice I have learnt over the years. I also made sure ssh access is strictly controlled. 

.⚖️ Key Design Trade-offs madeDesign DecisionChosen ApproachAlternative ConsideredJustification / Trade-offState ManagementTerraform Workspaces (dev / prod)Separate Remote Backend BucketsWorkspaces simplify single-repo deployments while sharing module definitions, though separate backends provide stronger blast-radius isolation.AuthenticationAWS OIDC IntegrationStatic IAM User KeysOIDC eliminates key rotation overhead and leaks risk, though it requires pre-configuring IAM Identity Providers in AWS.Compute ProvisioningSingle EC2 + ALBAuto Scaling Group (ASG)Kept simple to maintain Free-Tier compliance and minimal resource complexity for demonstration purposes.Configuration MgmtEC2 user_data + Local AnsibleDedicated Ansible Control Node / SSMInlines setup scripts directly into deployment without requiring auxiliary control plane infrastructure.🛠️ 

