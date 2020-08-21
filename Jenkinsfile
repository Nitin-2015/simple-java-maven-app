pipeline {
    agent any
     triggers {
        pollSCM "* * * * *"
     }
    environment {
        GITHUB = credentials('nitingit')

    }

    stages {
        stage('Checkout') {
            steps{
                checkout scm
            }
        }
        stage('Build') {
            steps {
                bat 'mvn -X -B -DskipTests clean package'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
                 }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                       }
                 }
                    }
       
     }
                
    }
