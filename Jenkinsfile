pipeline {
  agent any
  options {
    timestamps()
    skipDefaultCheckout(true)
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh 'echo "Building the project...'
        sh './gradlew build'
      }
    }

    stage('Test') {
      steps {
        sh './gradlew test'
        echo 'Running tests.'
      }
    }
  }
}
