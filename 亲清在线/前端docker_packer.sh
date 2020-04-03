#变量
PRE=registry.citybrain.local/a6013-pre/
SOURCE_IMAGE=py_330124_001_gov_pc
TAG=1.0.$BUILD_ID
BUILD_NAME=dist

node -v
npm -v
cnpm -v
cnpm i
#执行构建命令
npm run build
cp /home/dockerfile_v1.0 $WORKSPACE/dockerfile
if [ ! -z ${BUILD_NAME} ]; then
sed -i s/dist/${BUILD_NAME}/ $WORKSPACE/dockerfile
fi
cp /home/nginx.conf_v1.0 $WORKSPACE/nginx.conf
cp /home/default.conf_v1.0 $WORKSPACE/default.conf
cd $WORKSPACE
sudo docker version
#打包docker镜像
#sudo docker build --rm --tag py_330124_001_gov_pc:1.0.$BUILD_ID .
sudo docker build --rm --tag ${PRE}${SOURCE_IMAGE}:${TAG} .
#另存为镜像至工作区
#sudo docker save -o ./py_330124_001_gov_pc_1.0.$BUILD_ID.tar py_330124_001_gov_pc:0.0.$BUILD_ID
sudo docker save -o ./${SOURCE_IMAGE}_${TAG}.tar ${PRE}${SOURCE_IMAGE}:${TAG}
#更改文件属组
sudo chown jenkins:jenkins ./${SOURCE_IMAGE}_${TAG}.tar
#删除镜像
#sudo docker rmi $(docker images | grep py_330124_001_gov_pc | awk '{print $3}')
sudo docker rmi $(docker images | grep ${PRE}${SOURCE_IMAGE}:${TAG})
#删除无用镜像
#echo y| sudo docker image prune

#docker tag SOURCE_IMAGE[:TAG] registry.citybrain.local/a6013-pre/IMAGE[:TAG]
#docker push registry.citybrain.local/a6013-pre/IMAGE[:TAG]