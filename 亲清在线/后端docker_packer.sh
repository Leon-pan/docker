#变量
PRE=registry.citybrain.local/a6013-pre/
SOURCE_IMAGE=py_330124_001_gov_backend
TAG=1.0.$BUILD_ID
BUILD_NAME=policy-back-1.0.0.jar
WORK_SPACE=$WORKSPACE/target

cp /home/dockerfile_backend_qqzx $WORK_SPACE/dockerfile
if [ ! -z ${BUILD_NAME} ]; then
sed -i s/policy-back-1.0.0.jar/${BUILD_NAME}/ $WORK_SPACE/dockerfile
fi
cd $WORK_SPACE
sudo docker version
#打包docker镜像
#sudo docker build --rm --tag py_330124_001_gov_backend:1.0.$BUILD_ID .
sudo docker build --rm --tag ${PRE}${SOURCE_IMAGE}:${TAG} .
#另存为镜像至工作区
#sudo docker save -o ./py_330124_001_gov_backend_1.0.$BUILD_ID.tar py_330124_001_gov_backend:1.0.$BUILD_ID
sudo docker save -o ./${SOURCE_IMAGE}_${TAG}.tar ${PRE}${SOURCE_IMAGE}:${TAG}
#更改文件属组
sudo chown jenkins:jenkins ./${SOURCE_IMAGE}_${TAG}.tar
#删除镜像
#sudo docker rmi -f $(docker images | grep registry.citybrain.local/a6013-pre/py_330124_001_gov_backend | awk '{print $3}')
sudo docker rmi ${PRE}${SOURCE_IMAGE}:${TAG} && exit 0
#删除无用镜像
#echo y| sudo docker image prune

#docker tag SOURCE_IMAGE[:TAG] registry.citybrain.local/a6013-pre/IMAGE[:TAG]
#docker push registry.citybrain.local/a6013-pre/IMAGE[:TAG]