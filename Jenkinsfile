pipeline {
    agent any
    options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  triggers {
    cron('@daily')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -f "Dockerfile" -t sushanttickoo22/tomcat:latest .'
      }
    }
    stage('Publish') {
      steps   
        {
         sh 'docker push sushanttickoo22/tomcat:latest'
        }
      
    }
  } 
}
