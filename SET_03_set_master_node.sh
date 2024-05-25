#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện devploy K8s

# Tắt swap
    sudo swapoff -a
    sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
# Chỉnh lại file containerd.conf ( ghi đè )
    sudo bash -c 'cat << EOF > /etc/modules-load.d/containerd.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF'
    sudo modprobe overlay
    sudo modprobe br_netfilter

# Chỉnh K8s networking config
    sudo bash -c 'cat << EOF > /etc/sysctl.d/kubernetes.conf
overlay
br_netfilter
EOF'
    sudo sysctl --system
# Set host-name
    
    read -p "Nhập hostname :" hostnameinp
    sudo hostnamectl set-hostname $hostnameinp

# Có thể vào /etc/host để config key-value ip - hostname nữa nma ở đây mình ko ghi :D

