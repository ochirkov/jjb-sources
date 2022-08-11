pipeline {

    agent any

    stages {

        stage("Checkout") {
            steps {
                git url: 'https://github.com/ochirkov/jjb-sources.git',
                    branch: "${env.GIT_BRANCH}"
            }
        }

        stage('Test') {
            steps {
                sh 'jenkins-jobs test -r jobs/'
            }
        }
    }
}