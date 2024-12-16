#!/bin/bash
# Update the system
dnf update -y

# Install Java (Jenkins requirement)
dnf install java-21-amazon-corretto -y

# Add Jenkins repository
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
dnf install jenkins -y

# Start Jenkins service
systemctl enable jenkins
systemctl start jenkins

# Save the initial admin password to a file in home directory for easy access
echo "Jenkins initial admin password: " > /home/ec2-user/jenkins-initial-password.txt
cat /var/lib/jenkins/secrets/initialAdminPassword >> /home/ec2-user/pass.txt
