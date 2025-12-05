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
                withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    // sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "sudo systemctl stop main" || true'
                    // sh 'scp -o StrictHostKeyChecking=no -i ${FILENAME} app ${USERNAME}@target:'

                    // sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "chmod +x app"'
                    // sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "sudo systemctl start main" || true'
                    sh 'ansible-playbook --inventory hosts.ini playbook.yml'
                }
            }
        }
    }
}
