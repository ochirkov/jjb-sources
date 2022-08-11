pipeline {

    agent any

    stages {

        stage("Checkout") {
            steps {
                git url: 'https://github.com/ochirkov/jjb-sources.git'
                    branch: main
            }
        }

        stage('Test') {
            steps {
                sh 'jenkins-jobs test -r jobs/'
            }
        }
    }
}