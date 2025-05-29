pipeline {
  agent any

  environment {
    IMAGE_NAME = "react-static-app"
    DEV_REPO = "sreedocker911/react-app-dev:latest"
    PROD_REPO = "sreedocker911/react-app-prod:latest"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM',
          userRemoteConfigs: [[
            url: 'https://github.com/sriram-R-krishnan/devops-build.git',
            credentialsId: 'github-creds'
          ]],
          branches: [[name: '*/dev']]
        ])
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME ./devops-build'
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
            docker tag $IMAGE_NAME $DEV_REPO
            docker push $DEV_REPO
          '''
        }
      }
    }
  }
}
