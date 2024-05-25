#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện set env K8s để chuẩn bị tạo Cluster

# Install Docker - phần này được cài rồi nên sẽ để ghi chú , nếu chưa có thì có thể CTRL + K + U 
    # sudo apt update
    # sudo apt install docker.io -y
    # sudo systemctl enable 
    # sudo systemctl status docker
    # sudo systemctl start docker
# Install Kubernetes
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt update
# Install kubeadm , kubelet , kubectl
    sudo apt install kubeadm kubelet kubectl
    sudo apt-mark hold kubeadm kubelet kubectl # hold version 
    kubeadm version
