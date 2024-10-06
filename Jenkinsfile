pipeline{
    // agent any
    agent {
        docker { image 'docker:19.03' }
    tools{
        nodejs 'node'
    }
    stages{
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
                echo 'npm run lint'
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
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
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
}