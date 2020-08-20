pipeline {
    agent any
     triggers {
        pollSCM "* * * * *"
     }
    environment {
        GITHUB = credentials('NitinGithub')

    }

    stages {
        stage('Checkout') {
            steps{
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'mvn -X -B -DskipTests clean package'
            }
        }
         

        
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }


       
              
                
    }
}
