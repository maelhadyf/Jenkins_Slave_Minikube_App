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

### 2- connect the ec2-slave to jenkins master
-Add Credentials
  - Choose "SSH Username with private key"
  - ![image](https://github.com/user-attachments/assets/d7902d05-efab-4799-8fe5-3b361658c573)
