# My Protfolio Web Application with Terraform

This project demonstrates a two‑page AWS web application. It consists of a static landing page and an interactive data visualization page that fetches dynamic data from an AWS Lambda function via API Gateway. The entire infrastructure is provisioned using Terraform, ensuring a repeatable, manageable, and scalable deployment process.

## Technologies Used
- **AWS Services:**  
  - Amazon S3 for static website hosting
  - Amazon CloudFront for content delivery
  - Amazon API Gateway for creating RESTful APIs
  - AWS Lambda for serverless compute
  - Amazon Route 53 for DNS management
- **Infrastructure as Code:**
  - Terraform for provisioning and managing AWS resources
- **Programming Languages:**
  - Python for AWS Lambda function code
  - HTML, CSS, and JavaScript for the web application
- **Development Tools:**
  - Visual Studio Code for development
  - Git for version control
- **Deployment Tools:**
  - AWS CLI for managing AWS resources
  - Terraform CLI for provisioning infrastructure
- **Version Control:**
  - Git for source code management
- **Package Management:**
  - Python's `pip` for managing Lambda function dependencies
  - Node.js and npm for managing JavaScript dependencies
- **Testing and Debugging:**
  - Visual Studio Code for local development and debugging
  - AWS CloudWatch for monitoring and logging Lambda function execution

## Website Architecture Overview
- **Page 1: Static Website:**  
  A static landing page hosted on Amazon S3. It is served via Amazon CloudFront, and the domain is managed using Amazon Route 53. The static page includes HTML, CSS, and images.
  It is publicly accessible and serves as the entry point for users.

- **Page 2: Interactive Visualization:**  
  A single-page application (SPA) that fetches dynamic data from an AWS Lambda function. The SPA is hosted on Amazon S3 and served via Amazon CloudFront. It uses JavaScript to make API calls to the backend and render visualizations based on the fetched data. The Lambda function processes or retrieves data and returns it to the SPA. The SPA is designed to be interactive and responsive, providing users with a seamless experience.
  The SPA is hosted on Amazon S3 and served via Amazon CloudFront. It uses JavaScript to make API calls to the backend and render visualizations based on the fetched data. The Lambda function processes or retrieves data and returns it to the SPA.
  The SPA is designed to be interactive and responsive, providing users with a seamless experience.

- **Backend Processing:**  
  The backend consists of an AWS Lambda function, an API Gateway, and an IAM role. The Lambda function is responsible for processing or fetching dynamic data. It is triggered by HTTP requests from the SPA and communicates with other AWS services as needed. The API Gateway exposes the Lambda function as a RESTful API, allowing the SPA to interact with it securely. The IAM role associated with the Lambda function grants it the necessary permissions to access AWS resources, such as S3 buckets or DynamoDB tables.
- **Infrastructure Management:**
  The entire infrastructure is managed using Terraform, which allows for easy provisioning, updating, and versioning of AWS resources. Terraform configurations define the S3 buckets, CloudFront distributions, API Gateway endpoints, Lambda functions, IAM roles, and Route 53 records. This ensures that the infrastructure can be easily reproduced or modified as needed.

## Directory Structure
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

## Web Application Structure
- **Static Page:**  
  Located in `app/static/`, this folder contains the landing page (HTML, CSS, images) served publicly.
- **Interactive Page:**  
  Located in `app/interactive/`, this folder contains the interactive visualization page (HTML, CSS, JavaScript). It fetches data from the AWS Lambda function via API Gateway. The JavaScript code handles API calls and data rendering.
- **Assets:**
  The `app/static/` folder contains static assets such as images and stylesheets used in the landing page. The `app/interactive/` folder contains the interactive page's HTML, CSS, and JavaScript files. The JavaScript code handles API calls and data rendering.
- **Lambda Function:**
  The `lambda/` folder contains the AWS Lambda function code and its dependencies. The Lambda function is responsible for processing of dynamic data. It is a scheduled function that runs daily and fetches data from an external API. The function is triggered by an API Gateway endpoint, which allows the interactive page to make HTTP requests to it. The Lambda function is written in Python and uses the `requests` library to make HTTP requests to the external API. The function processes the data and returns it in a format suitable for the interactive page.

## Setup Instructions
1. **Clone the Repository:**
   ```bash
    git clone git clone https://github.com/jayadeyemi/JumpReact.git
    cd JumpReact
    ```
2. **Install Dependencies:**
    - For the Lambda function, navigate to the `lambda/` directory and install dependencies:
      ```bash
      cd lambda
      pip install -r requirements.txt -t .
      ```
    - For the interactive page, navigate to the `app/interactive/` directory and install any necessary JavaScript dependencies (if applicable).
      ```bash
      cd app/interactive
      npm install
      ```
3. **Configure AWS Credentials:**
    - Ensure your AWS credentials are set up. You can configure them using the AWS CLI:
      ```bash
      aws configure
      ```
    - Alternatively, set environment variables for `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION`.   
3. **Local Development:**
   - Modify your application assets in the `app/` folder.
   - Update your Lambda function code in the `lambda/` folder as needed.
   - Test changes locally before deploying

2. **Terraform Setup:**
   - Ensure you have [Terraform](https://www.terraform.io/downloads.html) installed.
   - Navigate to the `terraform/` directory:
     ```bash
     cd terraform
     terraform init
     ```
   - Review the planned changes:
     ```bash
     terraform plan -out tfplan -var-file=./terraform/environments/prod/terraform.tfvars
     ```
   - Apply the configuration:
     ```bash
     terraform apply tfplan
     ```

3. **Local Development:**
   - Modify your application assets in the `app/` folder.
   - Update your Lambda function code in the `lambda/` folder as needed.
   - Test changes locally before deploying.

## Deployment Process
- **Terraform:**  
  Terrraform deploys the infrastructure, including S3 buckets, CloudFront distributions, API Gateway endpoints, Lambda functions, IAM roles, and Route 53 records. The `terraform/` directory contains all the necessary configurations to provision the AWS resources.
- **Landing Page: Static Content**  
  Your static and interactive pages are uploaded to Amazon S3. CloudFront serves these pages globally, while Route 53 routes DNS traffic to CloudFront.

- **Dynamic Content:**  
  The interactive page calls an API Gateway endpoint, which triggers the Lambda function in the `lambda/` folder to fetch or process data.

- **Terraform:**  
  Use Terraform to provision and update your infrastructure, ensuring a consistent and automated deployment process.

## Additional Notes

- **Security:**  
  Sensitive assets can be kept private by using specific S3 bucket policies and object ACLs. For example, you can configure policies to prevent public access to files in a `private/` directory.
  
- **Environment Management:**  
  The optional `environments/` folder under Terraform can be used to manage different configurations for development, staging, and production environments.

- **AWS Credentials:**  
  Make sure your AWS credentials are properly configured (via environment variables, AWS CLI configuration, or another method) before running Terraform commands.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [AWS Documentation](https://docs.aws.amazon.com/)
- [Terraform Documentation](https://www.terraform.io/docs)
- [Visual Studio Code Documentation](https://code.visualstudio.com/docs)
