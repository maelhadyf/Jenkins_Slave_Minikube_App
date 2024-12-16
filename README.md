# Jenkins_Slave_Minikube_App

## Steps

### 1- Configure 2 ec2 Amazon Linux 2023
- create ec2 as jenkins master  
  - put this script `jenkins_container.sh` in ec2 **User data**
> **Important Note:**  
> open ports 8080, 50000

- create another ec2 as slave with all tools u need  
  - put this script `script_ec2_amazonlinux_slaveAgent_minikube_docker_OC.sh` in ec2 **User data**
  - **Instance type:** t2.mediuem
  - **Storage:** 20 GiB
> **Important Note**  
> run this code on ec2-slave if not use `script_ec2_amazonlinux_slaveAgent_minikube_docker_OC.sh`
```bash
# Install Java (required to connect to jenkins master)
yum install java-21-amazon-corretto -y

# Create a root directory for Jenkins agent
mkdir -p /opt/jenkins-agent
chown -R ec2-user:ec2-user /opt/jenkins-agent
```
### 2- connect the ec2-slave to jenkins master
#### 1- Add Credentials
  - Choose "SSH Username with private key"
    - ![image](https://github.com/user-attachments/assets/d7902d05-efab-4799-8fe5-3b361658c573)

#### 2- Add the new node in Jenkins
  - ![image](https://github.com/user-attachments/assets/d71a6ad3-6868-4629-bb27-d609e4cf2565)
  - ![image](https://github.com/user-attachments/assets/6f8b8f0c-a546-411a-8988-807fefef4a88)
  - ![image](https://github.com/user-attachments/assets/7eda5f67-3353-449d-b667-9e08c2cf4f1d)
  - ![image](https://github.com/user-attachments/assets/823ab945-f9e4-405b-8a40-664aec12cfde)
  - ![image](https://github.com/user-attachments/assets/23f841db-5732-4268-950a-360eb77b4f5f)
  - ![image](https://github.com/user-attachments/assets/e4960f75-b226-4540-94bb-12849a5f70ff)

### 3- Github Webhooks
#### 1- Install required plugins:
- GitHub Branch Source Plugin
- GitHub Integration Plugin
- Multibranch Scan Webhook Trigger Plugin




