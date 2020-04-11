pipeline {
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
      steps {
          sh 'docker push sushanttickoo22/tomcat:latest'
        }
    }
  }
}
