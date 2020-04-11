pipeline {
    environment {
    registry = "sushanttickoo22/tomcat"
    registryCredential = ‘dockerhub’
  }
  agent { label 'slave' }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -f "Dockerfile" -t sushanttickoo22/tomcat:latest .'
      }
    }
  stage('Publish') {
    steps{    script {
      docker.withRegistry( '', registryCredential ) {
        dockerImage.push()
      }
    }
  }
}
    }
  }
}
