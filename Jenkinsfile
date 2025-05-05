pipeline {
    agent any

    stages {
        stage('Instalar dependencias') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                sh 'pytest tests'
            }
        }

        stage('Build') {
            steps {
                sh 'pyinstaller --onefile main.py'
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'dist/*', fingerprint: true
        }
    }
}
