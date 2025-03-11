pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "webapp"
        DOCKER_TAG = "latest"
        DOCKER_REGISTRY = "arwindersingh82"
        LOCAL_DOCKER_HOST = "tcp://dockserv:2375"
        GIT_REPO = "https://github.com/arwindersingh82/webapp.git"
        DOCKER_SERVER = "root@dockserv"
        SSH_COMMAND = "ssh -o StrictHostKeyChecking=no ${DOCKER_SERVER}"
    }

//                 git ${GIT_REPO} // Change to your repo

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/arwindersingh82/webapp.git'
            }
        }

        stage('Remove old image') {
            steps {
                sshagent(['arnieAsusMainKey']) {
                    sh """
                    ${SSH_COMMAND} "docker rm ${DOCKER_IMAGE} || true"
                    """
                }
            }
        }

        stage('Checkout the Latest Code from GitHub') {
            steps {
                sshagent(['arnieAsusMainKey']) {
                    sh """
                    ${SSH_COMMAND} "mkdir -p /root/webapp"
                    ${SSH_COMMAND} "cd /root/"  # Change to your project directory
                    ${SSH_COMMAND} "git clone ${GIT_REPO}""
                    """
                }
            }
        }

        stage('Build the docker image') {
            steps {
                sshagent(['arnieAsusMainKey']) {
                    sh """
                    ${SSH_COMMAND} "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                    """
                }
            }
        }

        stage('Run the docker image') {
            steps {
                sshagent(['arnieAsusMainKey']) {
                    sh """
                    ${SSH_COMMAND} "docker run -d -p 8080:80 --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    """
                }
            }
        }

//                 git pull origin main  # Ensure latest code

//         stage('Build Docker Image') {
//             steps {
//                 sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
//             }
//         }

//         stage('Push to Registry') {
//            steps {
//                sh "docker -H ${DOCKER_HOST} build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
//            }
// //             steps {
// //                 sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}"
// //                 sh "docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}"
// //             }
//
//         }

//         stage('Deploy to Local Docker') {
//             steps {
//                 sh """
//                 docker -H ${DOCKER_HOST} stop ${DOCKER_IMAGE} || true
//                 docker -H ${DOCKER_HOST} rm ${DOCKER_IMAGE} || true
//                 docker -H ${DOCKER_HOST} run -d -p 8080:80 --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${DOCKER_TAG}
//                 """
//             }
// //             steps {
// //                 sshagent(['your-ssh-key-id']) {
// //                     sh """
// //                     ssh user@your-local-docker-server << EOF
// //                     docker pull ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}
// //                     docker stop ${DOCKER_IMAGE} || true
// //                     docker rm ${DOCKER_IMAGE} || true
// //                     docker run -d -p 8080:80 --name ${DOCKER_IMAGE} ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}
// //                     EOF
// //                     """
// //                 }
// //             }
//         }
        }
}