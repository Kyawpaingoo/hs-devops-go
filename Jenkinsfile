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
                sh 'scp app laborant@target:~'
            }
        }
    }
}
