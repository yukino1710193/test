#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện Reset workernode
# Reset Cluster
    echo y | sudo kubeadm reset

    sudo rm -rf /etc/cni/net.d
    sudo rm -rf $HOME/.kube/config
# yêu cầu nhập lệnh join cluster
    sudo systemctl stop apparmor && sudo systemctl disable apparmor
    sudo systemctl restart containerd.service
    echo "Qua master-node xóa node cũ , rôi sudo kubeadm token create --print-join-command"
    read -p "Nhập join_command :" join_command
    sudo $join_command --v=5