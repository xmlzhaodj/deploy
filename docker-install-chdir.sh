#!/bin/bash
mkdir -p /data/docker
if [ -f /etc/yum.repos.d/docker-ce.repo ];then
rm -rf /etc/yum.repos.d/docker-ce.repo
fi
yum -y remove docker*
curl  https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo
yum makecache
yum install docker-ce -y
systemctl enable docker
systemctl start docker
docker version
cat > /etc/docker/daemon.json <<EOF

{
    "data-root": "/data/docker",
    "storage-driver": "overlay2"
}
EOF

systemctl daemon-reload
systemctl restart docker