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
                sh "go build -o app app.go"
                sh "chmod +x app"
            }
        }
        // stage('Deploy') {
        //     steps {
        //         withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
        //             // sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "sudo systemctl stop app" || true'
        //             // sh 'scp -o StrictHostKeyChecking=no -i ${FILENAME} app ${USERNAME}@target:'

        //             // sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "chmod +x app"'
        //             // sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@target "sudo systemctl start app" || true'
        //             sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory hosts.ini --key-file ${FILENAME} playbook.yaml'
        //         }
        //     }
        // }
        stage ('Build Docker Image') {
            steps {
                sh "docker build . --tag my-go-app"
            }
        }
        stage("Docker Run Image"){
            steps {
                 withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker "docker stop my-go-app" || true'
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker "docker rm my-go-app || true"'
                    sh 'ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker "docker run -d -p 4444:4444 ttl.sh/my-go-app:"'
                }
            }
        }
    }
}
