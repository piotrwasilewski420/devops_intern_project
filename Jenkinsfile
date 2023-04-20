pipeline {
  agent {
  }

  stages {
    stage('Checkout') {
      steps {
        // Checkout the code from the repository
        checkout scm
      }
    }
    stage('Build') {
      steps {
        // Use Gradle to build the project and run tests
        sh 'echo "Building the project..."'
        sh './gradlew build'
      }
    }

    stage('Test') {
      steps {
        // Use Gradle to run tests
        sh './gradlew test'
        echo 'Running tests..'
      }
    }
  }
}
