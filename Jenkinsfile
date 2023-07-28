pipeline {
    agent any

    environment {
        SSH_KEY = credentials('ssh-private-key')
        EC2_INSTANCE = '34.221.203.80'
    }

    stages {
        stage('SCM') {
            steps {
                git branch: 'aws-cloud-deployment', changelog: false, poll: false, url: 'https://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@github.com/iatiqul/lms-devops-final.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('SSH to EC2') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key', keyFileVariable: 'SSH_KEY')]) {
                    script {
                        def sshCommand = 
                        sh "ssh -o StrictHostKeyChecking=no -i $SSH_KEY ec2-user@${env.EC2_INSTANCE}"
                    }
                }
            }
        }
        
        // stage('Kill Process') {
        //     steps {
        //         withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key', keyFileVariable: 'SSH_KEY_PATH')]) {
        //             sh "ssh -i $SSH_KEY_PATH ec2-user@${env.EC2_INSTANCE} 'sudo kill -9 \$(lsof -t -i:8090)'"
        //         }
        //     }
        // }
        
        // stage('Remove existing project root directory') {
        //     steps {
        //         withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key', keyFileVariable: 'SSH_KEY_PATH')]) {
        //             sh "ssh -i $SSH_KEY_PATH ec2-user@${env.EC2_INSTANCE} 'sudo rm -rf /home/ec2-user/lms-devops-final'"
        //         }
        //     }
        // }

        stage('Copy project') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key', keyFileVariable: 'SSH_KEY_PATH')]) {
                    //sh "ssh -i $SSH_KEY_PATH ec2-user@${env.EC2_INSTANCE} 'mkdir /home/ec2-user/final-project'"
                    sh "scp -i $SSH_KEY_PATH /var/lib/jenkins/workspace/aws-cloud-deployment-final/target/spark-lms-0.0.1-SNAPSHOT.jar ec2-user@${env.EC2_INSTANCE}:/home/ec2-user/final-project"
                }
            }
        }
        
        // stage('Clone project') {
        //     steps {
        //         withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key', keyFileVariable: 'SSH_KEY_PATH')]) {
        //             //sh "ssh -i $SSH_KEY_PATH ec2-user@${env.EC2_INSTANCE} 'mkdir /home/ec2-user/final-project'"
        //             //sh "ssh -i $SSH_KEY_PATH ec2-user@${env.EC2_INSTANCE} 'cd /home/ec2-user/final-project'"
        //             sh "ssh -i $SSH_KEY_PATH ec2-user@${env.EC2_INSTANCE} 'git clone -b aws-cloud-deployment https://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@github.com/iatiqul/lms-devops-final.git'"
        //         }
        //     }
        // }
        
        stage('Run web app') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key', keyFileVariable: 'SSH_KEY_PATH')]) {
                    //sh "ssh -i $SSH_KEY_PATH ec2-user@${env.EC2_INSTANCE} 'cd /home/ec2-user/lms-devops-final'"
                    sh "ssh -i $SSH_KEY_PATH ec2-user@${env.EC2_INSTANCE} 'java -jar /home/ec2-user/final-project/spark-lms-0.0.1-SNAPSHOT.jar'"
                }
            }
        }
    }
}

