pipeline {
  agent any

  environment {
    IMAGE_NAME = "react-static-app"
    DOCKERHUB_USER = "sreedocker911"
  }

  stages {
    stage('Clone Repo') {
      steps {
        git branch: 'dev', url: 'https://github.com/sriram-R-krishnan/devops-build'
      }
    }

    stage('Build Docker Image') {
      steps {
        echo "🛠️ Building Docker image..."
        sh './build.sh'
      }
    }

    stage('Tag Docker Images') {
      steps {
        echo "🏷️ Tagging images for Dev and Prod..."
        sh '''
          docker tag react-static-app $DOCKERHUB_USER/react-app-dev:latest
          docker tag react-static-app $DOCKERHUB_USER/react-app-prod:latest
        '''
      }
    }

//    stage('Deploy Container') {
//      steps {
//        echo "🚀 Deploying container..."
//        sh './deploy.sh'
//      }
//    }

    stage('Push Docker Images to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo "🔐 Logging in to DockerHub..."
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

            echo "📤 Pushing Dev image to DockerHub (public)..."
            docker push $DOCKERHUB_USER/react-app-dev:latest

            echo "📤 Pushing Prod image to DockerHub (private)..."
            docker push $DOCKERHUB_USER/react-app-prod:latest
          '''
        }
      }
    }
  }

  post {
    success {
      echo "✅ Deployment pipeline completed successfully."
    }
    failure {
      echo "❌ Deployment pipeline failed. Check logs above."
    }
  }
}

