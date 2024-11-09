# CI/CD Pipeline for Docker Application Deployment

## Overview

This project is designed to create a CI/CD pipeline using AWS services to automate the deployment of a Docker-based Python application. The pipeline ensures the entire process, from source code retrieval to deployment, is seamless and reliable.

## Components

### CloudFormation Template

The CloudFormation template is responsible for provisioning the required AWS infrastructure for the pipeline, including:

- **S3 Bucket**: Used for storing build artifacts generated during the pipeline execution.
- **IAM Roles**:
  - **CodePipelineRole**: Grants permissions needed for CodePipeline to access S3, CodeBuild, and CodeDeploy resources.
  - **CodeBuildRole**: Provides CodeBuild the ability to run builds, write logs, and interact with other services such as S3 and CodeDeploy.
  - **CodeDeployRole**: A role assigned to CodeDeploy, equipped with managed policies to facilitate deployments.
- **CodeBuild Project**: Configures the environment for building, testing, and packaging the application, leveraging Docker for containerization.
- **CodeDeploy Application and Deployment Group**: Specifies the deployment target, in this case, EC2 instances with a particular tag to identify them as suitable deployment targets.
- **CodePipeline**: Orchestrates the entire CI/CD workflow, managing each stage from source code retrieval from GitHub to deployment on EC2.

### Parameters

The template includes configurable parameters:
- **GitHubConnectionArn**: The ARN of the connection to GitHub via AWS CodeStar for integrating the source control.
- **RepositoryName**: The name of the repository containing the application source code.
- **BranchName**: Specifies the branch from which the source code is pulled (default is `main`).

### Outputs

- **PipelineName**: Outputs the name of the created CodePipeline for easy identification.

## Build Specification

The build specification defines the build and test process in CodeBuild. This includes:

- **Environment Variables**: Includes custom variables and secure credentials from AWS Parameter Store for accessing Docker registry services.
- **Phases**:
  - **Install Phase**: Sets up the Python environment and any dependencies required by the application.
  - **Pre-Build Phase**: Installs additional tools, such as a linter (`flake8`), and checks for code quality issues.
  - **Build Phase**: Runs unit tests to verify code functionality, builds the Docker image, and pushes it to a specified Docker registry.
  - **Post-Build Phase**: Confirms the successful completion of the build process.

- **Artifacts**: Defines the files and directories to be stored for subsequent pipeline stages.

## Application Specification

The application specification (`appspec.yml`) outlines the deployment lifecycle hooks for CodeDeploy:

- **ApplicationStop Hook**: Runs a script to stop any running container instances on the EC2 instance before deploying the new version.
- **AfterInstall Hook**: Executes a script to start the new container after the deployment package has been placed on the instance.

These hooks ensure the deployment is smooth by properly handling the stopping and starting of application services.

## Summary

This CI/CD pipeline:
- Retrieves the source code from a GitHub repository.
- Builds and tests the code in an automated environment using CodeBuild.
- Deploys the application to EC2 instances using CodeDeploy, managed by a well-orchestrated CodePipeline.

This setup promotes continuous integration and deployment practices, enhancing the reliability and maintainability of the development workflow.


