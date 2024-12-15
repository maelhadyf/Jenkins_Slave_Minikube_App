# Jenkins_Slave_Minikube_App

## Steps

### configure 2 ec2 Amazon Linux 2023
1- create ec2 as jenkins master
put this script `jenkins_container.sh` in ec2 **User data**
> **Important Note:**
> open ports 8080, 50000

2- create another ec2 as slave with all tools u need
put this script `script_ec2_amazonlinux_slaveAgent_minikube_docker_OC.sh` in ec2 **User data**
