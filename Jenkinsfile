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
  stage('Deployment') {
      sshagent (credentials: ['ssh-user']){
    sh 'ssh -o StrictHostKeyChecking=no -l root 35.184.245.246 uname -a'
  }
      steps{
          sh 'docker compose -f /app/docker-compose.yml down'
          sh 'docker compose -f /app/docker-compose.yml up'
      }
  }
  }
}
