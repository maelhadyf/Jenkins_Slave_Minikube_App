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
                // Ensure the namespace exists
                sh "kubectl get namespace ${NAMESPACE} || kubectl create namespace ${NAMESPACE}"
            }
        }
        
        stage('Create ConfigMap') {
            steps {
                script {
                    // Create ConfigMap from the appropriate HTML file
                    sh """
                        kubectl create configmap html-content \
                        --from-file=page.html=page.html \
                        -n ${NAMESPACE} \
                        --dry-run=client -o yaml | kubectl apply -f -
                    """

                    sh """
                        kubectl create configmap nginx-config \
                        -n ${NAMESPACE} \
                        --from-literal=default.conf='server {
                            listen 80;
                            server_name localhost;
                            location / {
                                root /usr/share/nginx/html;
                                index index.html;
                                autoindex on;
                            }
                        }'
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Check if namespace exists first, then create if it doesn't
                    sh """
                        kubectl get namespace ${NAMESPACE} >/dev/null 2>&1 || \
                        kubectl create namespace ${NAMESPACE} || \
                        (echo "Failed to create namespace ${NAMESPACE}" && exit 1)
                    """
                    
                    // Deploy to the appropriate namespace
                    sh """
                        kubectl apply -f deployment-service.yaml -n ${NAMESPACE}
                    """
                }
            }
        }
    }

    post {
        always {
            
            cleanWs()
        }
    }
}
