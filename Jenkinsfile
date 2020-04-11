stages {
  stage('Code Checkout') {
    stages {
      // One or more stages need to be included within the stages block.
    }

    agent {
      label 'Slave'
    }
  }

  stage('Code Test') {
    stages {
      // One or more stages need to be included within the stages block.
    }

    agent {
      label 'Slave'
    }
  }

  stage('Code Build') {
    stages {
      echo "Building the project."
      sudo chown -R jenkins:jenkins /app
      sudo chmod 766 -R /app
      docker build . -t sushanttickoo22/tomcat
      docker push sushanttickoo22/tomcat
    }

    agent {
      label 'Slave'
    }
  }

  stage('Deployment') {
    stages {
      echo "Deployment in progress."
      ssh jenkins@35.184.34.54
      sudo chown -R jenkins:jenkins /app
      sudo chmod 766 -R /app
      cd /app
      docker-compose -d up
      
      ssh jenkins@35.184.245.246
      sudo chown -R jenkins:jenkins /app
      sudo chmod 766 -R /app
      cd /app
      docker-compose -d up
    }

    agent {
      label 'Slave'
    }
  }

}