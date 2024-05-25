#!/bin/bash
    echo Đây là Yukino , tôi sẽ thực hiện devploy K8s

# Chỉnh lại file kubectl ( ghi đè )
    sudo bash -c 'cat << EOF > /etc/default/kubelet
KUBELET_EXTRA_ARGS="--cgroup-driver=cgroupfs"
EOF'
    sudo systemctl daemon-reload && sudo systemctl restart kubelet
# Daemon
    sudo bash -c 'cat << EOF > /etc/docker/daemon.json
{
      "exec-opts": ["native.cgroupdriver=systemd"],
      "log-driver": "json-file",
      "log-opts": {
      "max-size": "100m"
   },
       "storage-driver": "overlay2"
       }
EOF'
    sudo systemctl daemon-reload && sudo systemctl restart docker
# Chỉnh 10-kubeadm.conf
# sudo nano /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
# thêm dòng Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false" có rồi thì thôi 
    sudo systemctl daemon-reload && sudo systemctl restart kubelet