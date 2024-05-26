#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện add Network pod

# Create Network pod using Calico
    kubectl apply -f ~/Documents/test/kube-flannel.yml
    kubectl taint nodes --all node-role.kubernetes.io/control-plane-
    sudo ifconfig flannel.1 down
    sudo ifconfig flannel.1 up

# fix coreDNS pending 
# sudo nano /var/lib/kubelet/config.yaml
# evictionHard:
#   imagefs.available: 1%
#   memory.available: 100Mi
#   nodefs.available: 1%
#   nodefs.inodesFree: 1%
# sudo systemctl restart kubelet
#
# kubectl taint nodes <node-name> node.kubernetes.io/not-ready-
# kubectl apply -f ~/Documents/test/kube-flannel.yml
# kubectl delete pod -n kube-system coredns ...