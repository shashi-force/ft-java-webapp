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
        script {
          docker.build registry
        }
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
