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
  node{  
  def remote = [:]
    remote.host = '35.184.245.246'
    remote.user = 'jenkins'
    remote.password = '1234'
    remote.allowAnyHosts = true
    stage('Remote SSH') {
      sshCommand remote: remote, command: "cd /app/"
      sshCommand remote: remote, command: "docker-compose -d down"
      sshCommand remote: remote, command: "docker-compose -d up"
    }
  }
}
}  
