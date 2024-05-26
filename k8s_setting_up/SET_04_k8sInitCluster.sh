#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện reset 1 Cluster

# reset lại kubeadm để tạo mới 1 Cluster
    echo y | sudo kubeadm reset

    sudo rm -rf /etc/cni/net.d
    sudo rm -rf $HOME/.kube/config

# Giờ thì tạo cluster nào ( đã config trước environment rồi )
sudo kubeadm init --apiserver-advertise-address=192.168.101.126 --control-plane-endpoint=masternode --upload-certs --apiserver-bind-port=8080 --pod-network-cidr=192.128.0.0/16

    mkdir -p $HOME/.kube
    echo y | sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Create Network pod using Calico
