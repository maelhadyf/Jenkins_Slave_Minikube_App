# Jenkins_Slave_Minikube_App

## Lab 26: MultiBranch Pipeline Project  
Create 3 namespaces in you K8S environment.  
Create a Multibranch pipeline to automate the deployment in the namespace based on GitHub branch.  
Create Jenkins slave to run this pipeline  
Use github webhooks to trigger the pipeline  
![image](https://github.com/user-attachments/assets/88772068-f4a6-4b7b-97fa-c551c33acedb)

---

## Steps

### 1- Configure 2 ec2 Amazon Linux 2023
- create ec2 as jenkins master  
  - put this script `jenkins_as_service.sh` in ec2 **User data**
> **Important Note:**  
> open ports 8080, 50000 in security group

- create another ec2 as slave with all tools u need  
  - put this script `script_ec2_amazonlinux_slaveAgent_minikube_docker_OC.sh` in ec2 **User data**
  - **Instance type:** t2.mediuem
  - **Storage:** 20 GiB
  - run this code when machine running
    ```bash
    # start Minikube & switches kubectl context to Minikube
    minikube start
    minikube status
    minikube kubectl -- get pods
    kubectl config use-context minikube
    ```
 
> **Important Note**  
> run this code on **ec2-slave** if not use `script_ec2_amazonlinux_slaveAgent_minikube_docker_OC.sh`
```bash
# Install Java (required to connect to jenkins master)
yum install java-21-amazon-corretto -y

# Create a root directory for Jenkins agent
mkdir -p /opt/jenkins-agent
chown -R ec2-user:ec2-user /opt/jenkins-agent
```
---

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

---

### 3- Github Webhooks
#### 1- Install required plugins:
- GitHub Branch Source Plugin
- GitHub Integration Plugin
- Multibranch Scan Webhook Trigger Plugin

#### 2- Go to your repository settings
 - Click "Webhooks"
 - ![image](https://github.com/user-attachments/assets/a259bb7d-cda7-40bf-938e-a1a408c0eb83)
   
 - ![image](https://github.com/user-attachments/assets/bb66fe69-2303-456e-a27f-096584e22e06)
   
 - ![image](https://github.com/user-attachments/assets/fc9d72ca-ec19-4e1d-b695-a30493cb39c9)
   
 - ![image](https://github.com/user-attachments/assets/c50eaa1c-cc8c-423e-9d5b-dc49caffc9cc)
   
 - ![image](https://github.com/user-attachments/assets/703e90f6-18c1-47ab-8590-3fafa778aec9)

---

### 4- Configure Multi-branch Pipeline
- ![image](https://github.com/user-attachments/assets/94caf11e-646e-494d-bf78-a41d6b2112f2)

- ![image](https://github.com/user-attachments/assets/09971ee4-499d-4ef1-a245-5fa57db970c2)

- ![image](https://github.com/user-attachments/assets/7269a12c-95cb-4614-802a-1a920bd72d2c)

- ![image](https://github.com/user-attachments/assets/fc4cfcc7-24ee-4129-adb9-4859eed9aeb4)

- ![image](https://github.com/user-attachments/assets/6b564435-abf2-41b9-a4b0-325e3f3521f4)

---

### Verification
- ![image](https://github.com/user-attachments/assets/ed068255-f603-47e9-ba8b-6de8820941c4)
  
- ![image](https://github.com/user-attachments/assets/ade94e9f-21aa-400e-ba3c-de45201e19de)
  
- ![image](https://github.com/user-attachments/assets/bd289be7-bb47-49f9-bd51-ebe188a66e96)
  
- ![image](https://github.com/user-attachments/assets/c0c2a989-fbdd-4974-89e3-9e8f4ba4d0a5)
  
- ![image](https://github.com/user-attachments/assets/f0bcfc03-a35c-4e2e-a599-d5b925dd42f3)

---

## 📄 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## ✍️ Author
**King Memo**

## 🙏 Thank You!
Thank you for using this project. Your support and feedback are greatly appreciated!
