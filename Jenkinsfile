pipeline {
    agent any

    tools {
       go "1.24.1"
    }

    stages {
        stage('Test') {
            steps {
                sh "go test ./..."
            }
        }
        stage('Build') {
            steps {
                sh "go build app.go"
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'eee29bf5-babe-4e3c-b258-eed3585ca5cc', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "sudo systemctl stop main" || true'
                    sh 'scp -o StrictHostKeyChecking=no -i ${FILENAME} app ${USERNAME}@target:'
                    
                }
            }
        }
    }
}
