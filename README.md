# 🚀 Serverless Container Deployment

*An automated, serverless Fintech application deployment using Python, Docker, Terraform as well as AWS ECS Fargate.*

## 🛠️ Core Technologies

*   **Application:** Python, Flask
*   **Containerization:** Docker Desktop, Amazon Elastic Container Registry (ECR)
*   **Infrastructure as Code (IaC):** HashiCorp Terraform
*   **Cloud Provider:** Amazon Web Services (AWS)
*   **CI/CD Pipeline:** GitHub Actions
*   **Tools:** AWS CLI, Git, macOS (zsh)

## 🧠 Project Purpose

This project's purpose is to demonstrate modern DevOps engineering practices by taking a Python Flask application and fully automating its deployment into the cloud. It showcases key concepts which include the following:
*   **Containerization:** Packaging the application and its environment using Docker.
*   **Infrastructure as Code:** Deploying modular, reproducible and scalable cloud networks and compute clusters using Terraform.
*   **State Management:** Using S3 and DynamoDB for secure, locked Terraform remote state management.
*   **Continuous Integration & Deployment (CI/CD):** Building an automated pipeline with GitHub Actions that pushes Docker images to ECR and updates the ECS Fargate cluster seamlessly on every push.

## 🏗️ Architecture Overview

```
[ Developer Push ] 
       │
       ▼
 [ GitHub Repo ] ──────────┐
       │                   │ (GitHub Actions CI/CD)
       ▼                   ▼
 [ Terraform ]       [ Docker Build ]
  (Provisions)             │
       │                   ▼
       │               [ AWS ECR ] (Image Registry)
       │                   │
       ▼                   ▼
 [ AWS ECS (Fargate) ] ◄───┘
```

## 🥞 Application Stack

| Layer | Technology |
| :--- | :--- |
| **Frontend/Backend** | Python Flask (Port 5000) |
| **Containerization** | Docker |
| **Infrastructure** | Terraform |
| **Compute** | AWS ECS (Fargate) & ALB |
| **State Management** | AWS S3 & DynamoDB |
| **CI/CD** | GitHub Actions |

## 🗄️ Infrastructure Blueprint

```
AWS Cloud
├── VPC (Custom Network)
│   ├── Public Subnets (Internet Facing)
│   │   ├── Internet Gateway
│   │   └── Application Load Balancer (Port 80)
│   └── Private Subnets (Internal Only)
│       └── ECS Fargate Cluster
│           └── Flask App Task (Port 5000)
├── ECR (Container Registry)
└── S3 / DynamoDB (Terraform Remote State Backend)
```

## ⚙️ CI/CD Pipeline

The CI/CD workflow is handled by `.github/workflows/deploy.yml` and consists of the following automated steps upon every push to the repository:
1.  **Code Checkout:** GitHub Actions runner clones the repository.
2.  **AWS Authentication:** Utilizes access keys configured through GitHub Repository Secrets to allow us to securely authenticate with AWS to gain authorized access on the Principle of Least Privilege.
3.  **Docker Build & Tag:** Builds our Flask application in a Docker container locally on the runner.
4.  **Push to ECR:** Pushes the built image in our previous step to the AWS Elastic Container Registry.
5.  **ECS Deployment:** Updates the ECS Fargate service, automatically spinning down the old container instances and bringing up the new images with zero downtime.

## 📂 Repository Structure

```
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD Pipeline
├── app/
│   ├── app.py                  # Python Flask Application
│   ├── requirements.txt        # Python Dependencies
│   └── Dockerfile              # Docker Image Instructions
├── modules/
│   ├── backend/                # S3 & DynamoDB for Remote State
│   ├── ecr/                    # Elastic Container Registry code
│   ├── networking/             # VPC, Subnets, IGW, Route Tables
│   ├── security/               # ALB and ECS Security Groups
│   └── compute/                # ALB, ECS Cluster, Task Definitions
├── providers.tf                # AWS Provider & S3 Backend
├── variables.tf                # Root Variables
├── main.tf                     # Root Module hooking all sub-modules together
└── outputs.tf                  # Exported URLs (ALB DNS Name)
```

## 💻 Local Development

To test this application locally for yourself without the admin of deploying it to AWS, run the following commands on your CLI:

```bash
# Navigate to the application directory
cd app

# Build the Docker image natively
docker build -t serverless_container_deployment-fintech-repo:latest .

# Run the Docker container
docker run -p 5000:5000 serverless_container_deployment-fintech-repo:latest
```

## ⚠️ Disclaimer!

*This is a project that is specifically designed to demonstrate DevOps engineering practices as well as cloud operations. Therefore, the infrastructure is not intended for a live production deployment without further security measures or understanding as all resources should be destroyed through a `terraform destroy` command after evaluation or deployment to avoid AWS billing or incurring any unxpected costs.*

## 🧑‍💻 Author

* **Name:** Peter Mkhatshwa
* **Focus:** Cloud Computing