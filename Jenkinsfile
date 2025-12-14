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
                sh "docker build . --tag ttl.sh/my-go-app:2h"
            }
        }
        stage ('Push Docker Image') {
            steps {
                sh "docker push ttl.sh/my-go-app:2h"
            }
        }
        stage("Deploy to Kubernetes"){
            steps {
                withKubeConfig([credentialsId: 'myapikey', serverUrl: 'https://kubernetes:6443']) {
                  // sh 'kubectl apply -f deployment.yaml'
                  // sh 'kubectl apply -f service.yaml'
                //production
                  sh 'kubectl apply -f deployment.yaml --namespace production'
                  sh 'kubectl apply -f service.yaml --namespace production'
                }
            }
        }
    }
}
