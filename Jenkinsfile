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
                sh './gradlew clean bootJar test'
            }
            post {
                success {
                    junit 'build/test-results/**/*.xml'
                    archiveArtifacts 'build/libs/*.jar'
                }
            }
        }      
        stage('Upload Artifacts to Nexus') {
            steps {
                script {
                    nexusArtifactUploader(
                        nexusVersion: 'nexus3',
                        protocol: 'https',
                        nexusUrl: env.NEXUS_URL,
                        groupId: 'pl.pwasil',
                        version: '${BUILD_NUMBER}-SNAPSHOT',
                        repository: 'maven-snapshots-custom',
                        credentialsId: env.NEXUS_CREDENTIALS_ID,
                        artifacts: [
                            [
                                artifactId: 'petclinic',
                                type: 'jar',
                                classifier: '',
                                file: 'build/libs/spring-petclinic-3.0.0.jar'
                            ]
                        ]
                    )
                }
            }
        }      
        stage('Build and Push Docker Image to DockerHub') {
            steps {
                script {
                    docker.withRegistry(env.DOCKERHUB_REGISTRY, env.DOCKERHUB_CREDENTIALS_ID) {
                        def imageTag = "piotrwasilewski420/petclinic:${BUILD_NUMBER}-SNAPSHOT"
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
