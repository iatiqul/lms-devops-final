pipeline {
    agent any

    environment {
        CURR_VER = '1'
    }
    
    triggers {
        pollSCM('H/2 * * * *') // Polls the SCM every 2 minutes
    }
    
    stages {
        stage('SCM') {
            steps {
                script {
                    // Checkout source code from your version control system
                    //checkout scm
                    git branch: 'on-premise-deployment', changelog: false, poll: false, url: 'https://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@github.com/iatiqul/lms-devops-final.git'
                }
            }
        }
        
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    dockerImage = docker.build("iatiqul/spark-lms:${BUILD_ID}.0")
                }
            }
        }

        stage('Publish') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-cred-iatiqul') {
                        dockerImage.push()
                    }
                }
            }
        }
        
        stage('Remove image') {
            steps {
                // Run any tests if required
                // Example: sh 'docker run --rm your-docker-image-name npm test'
                sh 'docker rmi iatiqul/spark-lms:${BUILD_ID}.0'
            }
        }
        
        stage('Update deployment script') {
            steps {
                sh "sed -i -e 's/${CURR_VER}.0/${BUILD_ID}.0/g' deploy/spring_boot.yml"
            }
        }
        
        stage("Deploy to kubernetes") {
            steps {
                withKubeConfig(credentialsId: 'kube-cert-final', namespace: 'default') {
                    sh "kubectl apply -f deploy/spring_boot.yml"
                }
            }
        }
    }
}


