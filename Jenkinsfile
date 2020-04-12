pipeline {
  agent 'any'
  environment {
    registry = "sushanttickoo22/tomcat"
    registryCredential = ‘dockerhub’
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -f "Dockerfile" -t sushanttickoo22/tomcat:latest .'
      }
    }
  stage('Publish') {
      steps{    
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
      }
    }
  }
    }
  }
}
