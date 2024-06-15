#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện STOP 1 Cluster

# reset lại kubeadm để tạo mới 1 Cluster
    echo y | sudo kubeadm reset

    sudo rm -rf /etc/cni/net.d
    sudo rm -rf $HOME/.kube/config
