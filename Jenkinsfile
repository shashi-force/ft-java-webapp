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
        script {
          docker.withRegistry( '', registryCredential ) {
          sh 'docker push sushanttickoo22/tomcat:latest'
      }
    }
  } 
    stage{'Deployment') {
      steps {
        sh 'ssh jenkins@35.184.34.54'
        cd /app/
        sh 'docker compose up'  
      }
    }
    }
  }
}
