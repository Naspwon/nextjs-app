pipeline{
    agent any
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
    }
}