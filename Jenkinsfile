pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Add your Docker Hub credentials ID
        IMAGE_NAME = 'your-dockerhub-username/your-image-name'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/syedsab5/hello-world-python.git' // Update with your repo URL
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image("${env.IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    sh """
                    docker run -d -p 5000:5000 ${env.IMAGE_NAME}:${env.BUILD_NUMBER}
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Build, Push and Deploy were successful!'
        }
        failure {
            echo 'Something went wrong!'
        }
    }
}

