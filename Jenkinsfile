pipeline {
    agent any
    parameters {
        choice(name: 'AWS_Region', choices: ['ap-southeast-1', 'ap-southnorth-1'], description: 'AWS Region')
        booleanParam(name: 'Run_Terraform_FMT_Check', description: 'Whether or not run terraform format check')
    }
    environment {
        AWS_DEFAULT_REGION = "${params.AWS_Region}"
    }
    stages {
        stage('Example') {
            steps {
                script {
                    echo "String parameter value: ${params.AWS_Region}"
                    echo "Boolean parameter value: ${params.Run_Terraform_FMT_Check}"
                    sh 'echo "Hello World" > file_passed_to_next_stage.txt'
                }
            }
        }
        stage('Load AWS Credentials') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'young_rnd_sandbox']]) {
                    script {
                        sh 'cat file_passed_to_next_stage.txt'
                        // Access the credentials and set them as environment variables
                        env.AWS_ACCESS_KEY_ID = "${AWS_ACCESS_KEY_ID}"
                        env.AWS_SECRET_ACCESS_KEY = "${AWS_SECRET_ACCESS_KEY}"
                    }
                }
                script 
                    {
                        echo 'AWS Credentials configured'
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
                        def run_tf_check = "${params.Run_Terraform_FMT_Check}".toBoolean()
                        
                        if(run_tf_check){
                            
                            echo 'Runnig Terraform format check'
                            
                            // Run terraform fmt with the check option
                            def fmtCheck = sh(script: 'terraform fmt -check', returnStatus: true)
                            
                            // Check the exit status
                            if (fmtCheck != 0) {
                                error 'Terraform files are not properly formatted. Please run "terraform fmt".'
                            } else {
                                echo 'All Terraform files are properly formatted.'
                            }
                        }else{
                             echo 'Terraform format check is skipped'
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