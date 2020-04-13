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
   }
    stage('Deploy'){  
      steps{
            sh 'ssh jenkins@35.184.245.246 docker-compose down'
            sh 'ssh jenkins@35.184.245.246 docker-compose up -d'
      }
    }
  } 
}
