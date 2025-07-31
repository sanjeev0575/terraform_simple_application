pipeline {
  agent any

  environment {
    AWS_ACCOUNT_ID = '115456585578'
    AWS_REGION     = 'us-east-1'
    ECR_REPO       = 'my-simple-application'
    IMAGE_TAG      = 'latest'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', credentialsId: 'git credentials', url: 'https://github.com/sanjeev0575/terraform_simple_application.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}")
        }
      }
    }

    stage('Login to ECR') {
      steps {
        sh """
          aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
        """
      }
    }

    stage('Push to ECR') {
      steps {
        withCredentials([aws(
          credentialsId: 'aws-cred',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
        sh """
          docker tag ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}
          docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}
        """
      } }
    }

    stage('Terraform Deploy') {
      steps {
            sh 'terraform init'
            sh 'terraform apply -auto-approve'
          
        }
      }
    }
  }
