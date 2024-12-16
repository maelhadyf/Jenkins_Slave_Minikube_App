pipeline {
    agent {
        label 'ec2-slave'
    }
    
    environment {
        NAMESPACE = "${BRANCH_NAME == 'main' ? 'prod' : BRANCH_NAME == 'test' ? 'test' : 'dev'}"
    }

    stages {
        stage('Determine Environment') {
            steps {
                echo "Deploying to namespace: ${NAMESPACE}"
            }
        }
        
        stage('Create ConfigMap') {
            steps {
                script {
                    // Create ConfigMap from the appropriate HTML file
                    sh """
                        kubectl create configmap html-content \
                        --from-file=page.html=${NAMESPACE}/page.html \
                        -n ${NAMESPACE} \
                        --dry-run=client -o yaml | kubectl apply -f -
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Ensure the namespace exists
                    sh "kubectl get namespace ${NAMESPACE} || kubectl create namespace ${NAMESPACE}"
                    
                    // Deploy to the appropriate namespace
                    sh """
                        kubectl apply -f deployment-service.yaml -n ${NAMESPACE}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully!"
            cleanWs() // Clean workspace
            sh 'git clean -fdx' // Clean untracked files and directories
        }
        failure {
            echo "Pipeline failed!"
            cleanWs() // Clean workspace on failure too
            sh 'git clean -fdx' // Clean untracked files and directories
        }
    }
}