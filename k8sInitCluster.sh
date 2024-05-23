#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện reset 1 Cluster

# reset lại kubeadm để tạo mới 1 Cluster
    echo y | sudo kubeadm reset

    sudo rm -rf /etc/cni/net.d
    sudo rm -rf $HOME/.kube/config

# Giờ thì tạo cluster nào ( đã config trước environment rồi )
sudo kubeadm init --control-plane-endpoint=master-node --upload-certs --apiserver-bind-port=8080 --pod-network-cidr=10.244.0.0/16

    mkdir -p $HOME/.kube
    echo y | sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Create Network pod using flannel
    kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
    kubectl taint nodes --all node-role.kubernetes.io/control-plane-
