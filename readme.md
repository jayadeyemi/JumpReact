# AWS Web Application with Terraform

This project demonstrates a two‑page AWS web application. It consists of a static landing page and an interactive data visualization page that fetches dynamic data from an AWS Lambda function via API Gateway. The entire infrastructure is provisioned using Terraform, ensuring a repeatable, manageable, and scalable deployment process.

## Architecture Overview

- **Static Website:**  
  Hosted on Amazon S3, the static landing page is served via CloudFront and routed using Route 53. This page includes HTML, CSS, and images to welcome users.

- **Interactive Visualization:**  
  A Single Page Application (SPA) hosted in the `app/interactive` directory. It dynamically updates its data by calling an API endpoint.

- **Backend Processing:**  
  AWS Lambda functions process or fetch dynamic data. The Lambda function is exposed to the SPA via API Gateway.

- **Infrastructure as Code:**  
  Terraform defines and deploys all AWS resources (S3 buckets, CloudFront distributions, Route 53 records, Lambda functions, etc.), ensuring that the infrastructure can be easily reproduced or modified.

## Structure
The project is organized into several directories, each serving a specific purpose. Below is a high-level overview of the directory structure:
```plaintext
JumpReact/
├── terraform/              # Terraform configurations for AWS resources
│   ├── backend.tf          # Remote backend configuration for Terraform state
│   ├── data.tf             # Data source definitions
│   ├── locals.tf           # Local values used in Terraform
│   ├── main.tf             # Primary Terraform configuration
│   ├── outputs.tf          # Outputs to expose resource information
│   ├── providers.tf        # Provider configurations (AWS)
│   ├── terraform.tfvars    # Variable values for default environment
│   ├── variables.tf        # Variable definitions
│   |
│   ├── modules/            # Reusable modules for Terraform resources
│   │   ├── api_gateway/    # API Gateway module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── cloudfront/     # CloudFront distribution module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── iam/            # IAM roles and policies module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── lambda/         # Lambda function module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   ├── route53/        # Route 53 DNS module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   │
│   │   └── s3/             # S3 bucket module
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   └── environments/       # Environment-specific configurations (optional)
│       ├── example/       # Example environment configurations
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── backend.tf
│       │
│       └── prod/           # Production environment-specific configurations
│           ├── main.tf
│           ├── variables.tf
│           ├── backend.tf
│           └── terraform.tfvars
│
├── app/                # Application assets
│   ├── static/         # Static assets for the landing page
│   │   ├── index.html
│   │   ├── styles.css
│   │   └── images/
│   │       ├── logo1.png
│   │       ├── logo2.png
│   │       ├── logo3.png
│   │       └── photo.png
│   │
│   └── interactive/    # Interactive visualization page assets
│       ├── interactive.html
│       ├── styles.css
│       └── scripts/
│           └── main.js
│
├── lambda/             # AWS Lambda function code and dependencies
│   ├── lambda_function.py
│   └── requirements.txt
│
├── .vscode/            # VS Code workspace settings and launch configurations
│   ├── settings.json
│   ├── tasks.json
│   └── launch.json
│
├── .gitignore          # Git ignore file
└── README.md           # Project documentation
```


## Components

### Terraform
- **Location:** `terraform/`
- **Purpose:**  
  Contains all infrastructure definitions. The root contains core configuration files, while the `modules/` directory holds reusable modules for resources like S3, CloudFront, and Route 53. The optional `environments/` directory allows for environment-specific configurations.

### Application (App)
- **Static Page:**  
  Located in `app/static/`, this folder contains the landing page (HTML, CSS, images) served publicly.
- **Interactive Page:**  
  Located in `app/interactive/`, this SPA fetches dynamic data and renders visualizations. It uses JavaScript (e.g., with fetch/AJAX) to communicate with the backend.

### Lambda
- **Location:** `lambda/`
- **Purpose:**  
  Contains the AWS Lambda function code that processes data or retrieves dynamic content for the interactive visualization. Dependencies are managed via `requirements.txt`.

### VS Code Configuration
- **Location:** `.vscode/`
- **Purpose:**  
  Provides project-specific settings, task definitions, and debugging configurations to streamline development and deployment processes.

## Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone <repository-url>
   cd my-project
#   J u m p R e a c t  
 