pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = "ap-southeast-1"
    }
    stages {
        stage('Load AWS Credentials') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'young_rnd_sandbox']]) {
                    script {
                        // Access the credentials and set them as environment variables
                        env.AWS_ACCESS_KEY_ID = "${AWS_ACCESS_KEY_ID}"
                        env.AWS_SECRET_ACCESS_KEY = "${AWS_SECRET_ACCESS_KEY}"
                    }
                }
            }
        }
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/XiamiYoung/jenkins'
            }
        }
        stage('Terraform init') {
            steps {
                script 
                    {
                        sh 'terraform init'
                    }
                }
            }
        stage('Terraform fmt check') {
            steps {
                script 
                    {
                        // Run terraform fmt with the check option
                        def fmtCheck = sh(script: 'terraform fmt -check', returnStatus: true)
    
                        // Check the exit status
                        if (fmtCheck != 0) {
                            error 'Terraform files are not properly formatted. Please run "terraform fmt".'
                        } else {
                            echo 'All Terraform files are properly formatted.'
                        }
                    }
                }
            }
        stage('Terraform validate') {
            steps {
                script 
                    {
                        sh 'terraform validate'
                    }
                }
            }
        stage('Terraform plan') {
            steps {
                script 
                    {
                        sh 'terraform plan'
                    }
                }
            }
        stage('Terraform apply') {
            steps {
                script 
                    {
                        sh 'terraform init'
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
     }
}