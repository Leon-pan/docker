curl -skSL https://mirror.azure.cn/repo/install-docker-ce.sh | sh -s -- --mirror Aliyun

cat /etc/docker/daemon.json <<- 'EOF'
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
EOF