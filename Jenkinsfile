pipeline {
  agent 'any'
  environment {
    registry = 'sushanttickoo22/tomcat'
    registryCredential = 'dockerhub'
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -f "Dockerfile" -t sushanttickoo22/tomcat:latest .'
      }
    }
  stage('Publish') {
      steps{    
        sh 'docker push sushanttickoo22/tomcat:latest'
      }
    }
  }
}
