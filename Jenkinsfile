pipeline{
    // agent any
    agent { 
        docker {
            image 'node:20.18.0-alpine3.20'
            label 'docker-agent' // Use the label you specified for your Docker agents
        }
     }
    tools{
        nodejs 'node'
    }
    stages{
        stage('Test') {
            steps {
                sh 'echo "Running inside Docker"'
                sh 'node --version' // Example command to verify Node.js
            }
        }
        stage('git clone'){
            steps{
                git(
                    url: 'https://github.com/Naspwon/nextjs-app.git',
                    branch: 'main'
                )
            }
        }
        stage('install dependencies'){
            steps{
                sh 'npm install'
            }
        }
        stage('Test application'){
            steps{
                sh 'npm run lint'
            }
        }
        stage('Run application'){
            steps{
                sh 'nohup npm run dev &'
                sleep 10
                sh 'curl -I http://localhost:3000 || exit 1'
            }
        }
        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "missnayomie/nextjs-app:${env.BUILD_ID}" // Replace with your Docker Hub username
                    sh "docker build -t $imageName ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    def imageName = "missnayomie/nextjs-app:${env.BUILD_ID}" // Replace with your Docker Hub username
                    sh "docker push $imageName"
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}