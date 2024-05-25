#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện add Network pod

# Create Network pod using Calico
    kubectl apply -f ~/Documents/test/kube-flannel.yml
    