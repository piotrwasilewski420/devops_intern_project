pipeline {
    agent {
      label 'worker-node'
    }
    environment {
        // Define your environment variables here
        NEXUS_URL = "nexus.pwasil.pl"
        NEXUS_CREDENTIALS_ID = "nexus-credentials"
        DOCKERHUB_REGISTRY = "https://index.docker.io/v1/"
        DOCKERHUB_CREDENTIALS_ID = "dockerhub-credentials"
    }
    stages {
        stage('Build and Test') {
            steps {
                sh './gradlew clean shadowJar test'
            }
            post {
                success {
                    junit 'build/test-results/**/*.xml'
                }
            }
        }   
        stage('Push to Nexus snapshot repository') {
            steps {
               sh "./gradlew -Pversion=${BUILD_NUMBER} publish"
            }
        }
        stage('Build and Push Docker Image to DockerHub') {
            steps {
                script {
                    docker.withRegistry(env.DOCKERHUB_REGISTRY, env.DOCKERHUB_CREDENTIALS_ID) {
                        def imageTag = "piotrwasilewski420/petclinic-snapshots:${BUILD_NUMBER}-SNAPSHOT"
                        def dockerfile = 'Dockerfile'
                        def context = '.'
                        
                        def image = docker.build(imageTag, "-f ${dockerfile} ${context}")
                        image.push()
                    }
                }
            }
        }
    }
}
