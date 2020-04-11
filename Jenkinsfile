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
      docker build  "gcr.io.sushanttickoo22/tomcat"
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
      cd /app
      docker-compose down
      docker-compose -d up
      
      ssh jenkins@35.184.245.246
      cd /app
      docker-compose down
      docker-compose -d up
    }

    agent {
      label 'Slave'
    }
  }

}
