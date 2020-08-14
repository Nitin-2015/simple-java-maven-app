@Library('github.com/releaseworks/jenkinslib') _
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
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }


        stage('Build Docker Image') {
                            when {
                                branch 'master'
                            }

                            steps {
                               withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'd2f221f3-4515-46cc-800b-b089de98dbf3', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        AWS("--region=us-east-2 s3 ls")
    }
                            }
                }
                stage('Push Docker Image') {
                            when {
                                branch 'master'
                            }
                            steps {
                                echo '=== Pushing simple-java-maven-app Docker Image ==='
                                script {
                                    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
                                    SHORT_COMMIT = "${GIT_COMMIT_HASH[0..7]}"
                                    docker.withRegistry('https://registry.hub.docker.com', 'NitinDocker') {
                                        app.push("$SHORT_COMMIT")
                                        app.push("latest")
                                    }
                                }
                            }
                }
                stage('Remove local images') {
                            steps {
                                echo '=== Delete the local docker images ==='
                                sh("docker rmi -f luckynitin/simple-java-maven-app:latest || :")
                                sh("docker rmi -f luckynitin/simple-java-maven-app:$SHORT_COMMIT || :")
                }
            }
    }
}
