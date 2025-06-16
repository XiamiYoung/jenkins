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
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/XiamiYoung/jenkins'
            }
        }
        stage('configure aws credentials') {
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