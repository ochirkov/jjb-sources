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
           when {
               not {
                   branch 'master'
               }
           }
            steps {
                sh 'jenkins-jobs test -r jobs/'
            }
        }

        stage('Update') {
            when {
                branch 'master'
            }
            steps {
                sh 'jenkins-jobs --conf jjb_config.ini update -r jobs/'
            }
        }
    }
}