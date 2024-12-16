#!/bin/bash

# Log all output to user-data.log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting installation script..."

# Update system
echo "Updating system packages..."
yum update -y

# Install Docker
echo "Installing Docker..."
yum install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install required packages for Minikube
echo "Installing dependencies..."
yum install -y conntrack

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# minikube
minikube start
minikube status
minikube kubectl -- get pods
kubectl config use-context minikube


# Install OpenShift CLI
echo "Installing OpenShift CLI..."
curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz
tar xvf openshift-client-linux.tar.gz
mv oc /usr/local/bin/
mv kubectl /usr/local/bin/
rm openshift-client-linux.tar.gz

# Install Java (required to connect to jenkins master)
yum install java-21-amazon-corretto -y

# Install git
yum install git -y

# Create a directory for Jenkins agent
mkdir -p /opt/jenkins-agent
chown -R ec2-user:ec2-user /opt/jenkins-agent



# Verify installations
echo "Verifying installations..."
echo "Docker version:"
docker --version
echo "Minikube version:"
minikube version
echo "Kubectl version:"
kubectl version --client
echo "OpenShift CLI version:"
oc version

# Create a script to display installation status
cat << 'EOF' > /home/ec2-user/installation_status.sh
#!/bin/bash
echo "Docker status: $(systemctl is-active docker)"
echo "Docker version: $(docker --version)"
echo "Minikube version: $(minikube version)"
echo "Kubectl version: $(kubectl version --client)"
echo "OpenShift CLI version: $(oc version)"
EOF

# Make the status script executable and set ownership
chmod +x /home/ec2-user/installation_status.sh
chown ec2-user:ec2-user /home/ec2-user/installation_status.sh

echo "Installation complete! Log file available at /var/log/user-data.log"
echo "Run ./installation_status.sh to verify installation status"
