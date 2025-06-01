pipeline {
  agent any

  environment {
    IMAGE_NAME = "react-static-app"
    DOCKERHUB_USER = "sreedocker911"
  }

  triggers {
    pollSCM('* * * * *')
  }

  stages {
    stage('Clone Repo') {
      steps {
        script {
          def branchToUse = env.BRANCH_NAME ?: 'dev'
          echo "📦 Cloning branch: ${branchToUse}"
          checkout([$class: 'GitSCM',
            branches: [[name: "*/${branchToUse}" ]],
            userRemoteConfigs: [[url: 'https://github.com/sriram-R-krishnan/devops-build']]
          ])
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        echo "Building Docker image..."
        sh './build.sh'
      }
    }

    stage('Tag Docker Images') {
      steps {
        echo "Tagging Docker image for dev/prod..."
        sh '''
          docker tag react-static-app $DOCKERHUB_USER/react-app-dev:latest
          docker tag react-static-app $DOCKERHUB_USER/react-app-prod:latest
        '''
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
            if [ "$BRANCH_NAME" == "master" ]; then
              docker push $DOCKERHUB_USER/react-app-prod:latest
            else
              docker push $DOCKERHUB_USER/react-app-dev:latest
            fi
          '''
        }
      }
    }

    stage('Deploy Container') {
      steps {
        echo "Deploying container..."
        sh './deploy.sh'
      }
    }
  }

  post {
    success {
      echo "✅ CI/CD Pipeline completed successfully."
    }
    failure {
      echo "❌ CI/CD Pipeline failed."
    }
  }
}
