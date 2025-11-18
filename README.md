# Automated Infrastructure Setup

This project demonstrates how to automate infrastructure provisioning using **Terraform** and **Jenkins**.

## Overview

This setup allows you to automatically create and destroy AWS resources with Terraform using a CI/CD pipeline in Jenkins. The pipeline pulls your Terraform code from GitHub, initializes Terraform, validates the syntax, and applies or destroys infrastructure based on the Jenkinsfile.

## Tools Used

* **Terraform** for Infrastructure as Code
* **Jenkins** for automation
* **AWS** as the cloud provider
* **GitHub** for source code management

## How It Works

1. Developer pushes code to GitHub
2. Jenkins fetches the repository
3. Jenkins pipeline runs the following stages:

   * **Init**: Initializes Terraform
   * **Validate**: Checks Terraform syntax
   * **Apply/Destroy**: Provisions or destroys infrastructure

## Pipeline Files

* `Jenkinsfile-create` → Creates AWS infrastructure
* `Jenkinsfile-destroy` → Destroys AWS infrastructure

## Credentials

Store your AWS credentials in Jenkins using **Credentials ID:** `aws-creds`

## Running the Pipeline

1. Commit your Terraform files and Jenkinsfile to GitHub
2. Trigger the Jenkins pipeline manually or automatically
3. Monitor stages in Jenkins Stage View

## Folder Structure

```
├── vpc.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── alb.tf
├── ec2.tf
├── security-grp.tf
├── Jenkinsfile-create
└── Jenkinsfile-destroy
```

## Notes

* Terraform State should be handled carefully
* Ensure AWS IAM user has required permissions

