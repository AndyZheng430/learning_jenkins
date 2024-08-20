pipeline {
// runs the pipeline
    agent any

// environments {
//     KEY = VALUE 
// }
    stages {
        stage('Build') {
            steps {
                // script {
                //     uses with plugins
                //     withAWS {}
                // }
                sh "echo Building Stage 1"
            }
        }
        stage('Test') {
            steps {
                sh "echo Testing Stage 2"
            }
        }
        stage('TestGithubWebhook') {
            steps {
                sh "echo Github Webhook Testing"
            }
        }
        stage('Deploy') {
            steps {
                sh "echo Deploying Stage 2"
            }
        }
    }
}
