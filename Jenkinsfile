pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub' // Your Docker Hub credentials ID
        DOCKER_IMAGE_NAME = 'web_app' // Name for the Docker image
        ANSIBLE_PLAYBOOK = 'deploy.yml' // Ansible playbook (not used in the build stage)
        TERRAFORM_DIR = 'terraform/'  // Directory containing your Terraform configuration
    }

    stages {
        stage('Cleanup') {
            steps {
                cleanWs() // Clean workspace before starting
            }
        }

        stage('Checkout') {
            steps {
                // Check out the code from the specified Git repository
                // git branch: 'main', credentialsId: 'Git', url: 'https://github.com/Rawan-abdelfattah/devops'
                git branch: 'main', url: 'https://github.com/Rawan-abdelfattah/devops'

            }
        }

        stage('key generation'){
            steps{
                sh '''
                cd terraform
                ssh-keygen -f mykey
                cp mykey ~/.ssh/
                cp mykey.pub ~/.ssh/
                cd ..
                '''
            }
        }

        stage('Install Terraform') {
            steps {
                script {
                    // Make sure the Terraform version is set
                    def terraformVersion = '1.5.3' // Change this to the desired version

                    sh """
                        # Remove existing Terraform if it's a directory or file
                        if [ -d /usr/local/bin/terraform ]; then
                            echo "Removing existing terraform directory"
                            sudo rm -rf /usr/local/bin/terraform
                        elif [ -f /usr/local/bin/terraform ]; then
                            echo "Removing existing terraform file"
                            sudo rm -f /usr/local/bin/terraform
                        fi

                        # Download the Terraform binary
                        wget https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip

                        # Unzip the binary
                        unzip -o terraform_${terraformVersion}_linux_amd64.zip

                        # Move the binary to /usr/local/bin
                        sudo mv terraform /usr/local/bin/                
                    """
                }
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir(TERRAFORM_DIR) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir(TERRAFORM_DIR) {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir(TERRAFORM_DIR) {
                        sh 'terraform apply -input=false tfplan'
                    }
                }
            }
        }


        stage('Build Docker Image') {
            steps {
                // Use Docker Hub credentials to log in
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    // Log in to Docker Hub
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    
                    // Build the Docker image using Docker Compose
                    sh 'docker-compose build' // Include --verbose for more detailed output
                }
            }
        }
    }

    post {
        always {
            // Logout from Docker after the build is complete to clean up
            sh 'docker logout'
        }
    }
}
