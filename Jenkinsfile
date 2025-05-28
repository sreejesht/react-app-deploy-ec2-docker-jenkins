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
        sh './build.sh'
      }
    }

    stage('Deploy Container') {
      steps {
        sh './deploy.sh'
      }
    }

    stage('Push Docker Images') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
          sh './push-docker-images.sh'
        }
      }
    }
  }
}

