pipeline {
    agent any

    tools {
       go "1.24.1"
    }

    stages {
         stage('Install Dependencies') {
            steps {
                sh "go mod tidy"
            }
        }
        stage('Test') {
            steps {
                sh "go test ./..."
            }
        }
        stage('Build') {
            steps {
                sh "go build -o app app.go"
                sh "chmod +x app"
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'target-ssh-key', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "sudo systemctl stop app" || true'
                    sh 'scp -o StrictHostKeyChecking=no -i ${FILENAME} app app.service ${USERNAME}@target:'

                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "chmod +x app"'
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "sudo systemctl start app" || true'
                    // sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory hosts.ini --key-file ${FILENAME} playbook.yaml'
                }
            }
        }
        
    }
}
