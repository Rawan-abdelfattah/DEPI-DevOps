# DevOps Website Deployment with AWS, Terraform, Ansible, and Jenkins

This project automates the deployment of a copy-center web application (frontend (react), backend (node), MongoDB) using AWS infrastructure, Terraform for provisioning, Ansible for configuration management, and Jenkins for CI/CD. The repository includes Ansible playbooks, Terraform configurations, and shell scripts to simplify the deployment process.

## Table of Contents
- [Project Overview](#project-overview)
- [Dependencies](#dependencies)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)

## Project Overview

This project automates the following tasks:
- Provisioning AWS EC2 instances with Terraform.
- Configuring the instances using Ansible.
- Building Docker images, pushing them to Docker Hub, and deploying them on EC2 instances.
- Setting up a CI/CD pipeline using Jenkins.

## Dependencies

Ensure the following dependencies are installed on your local environment:
- **Terraform**: Infrastructure provisioning.
- **Ansible**: Configuration management and dynamic inventory.
- **Boto/Boto3**: Required for Ansible's AWS dynamic inventory.
    - Install using `pip`:
    ```bash
    pip install boto boto3
    ```
- **AWS CLI**: For AWS resource management.
- **Jenkins**: CI/CD pipeline for automating the build and deployment process.

## Project Structure

- `client/`: Frontend code
- `server/`: Backend code
- `terraform/`: Contains Terraform configuration files for provisioning AWS resources.
- `ansible/`: Contains Ansible playbooks for Docker setup and application deployment.
- `quick-run.sh`: Automates key steps such as key generation, Terraform setup, and running Ansible playbooks.
- `after-build.sh`: Executes additional Ansible playbooks after Jenkins completes the build process.
- `Jenkinsfile`: for building dockerimages and pushing to dockerhub

## Quick Start

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
    ```

2. **Run the `quick-run.sh` script**:
    This script handles the key steps of provisioning infrastructure and setting up environments.
    ```bash
    ./quick-run.sh
    ```

3. **Build with Jenkins**:
    Configure Jenkins to run the build and deployment steps found in ***Jenkinsfile***.
    - Jenkins will build Docker images, push them to Docker Hub, and trigger the Ansible playbooks for deploying the app.

4. **Run the `after-build.sh` script**:
    After the Jenkins pipeline has completed, run the final Ansible playbooks for the deployment:
    ```bash
    ./after-build.sh
    ```


## CI/CD with Jenkins

The Jenkins pipeline is responsible for:
- Building Docker images for the frontend and backend services.
- Pushing the images to Docker Hub.

}

## License

This project is licensed under the MIT License.

```Feel free to adjust the URLs and paths based on your actual repository setup.```
