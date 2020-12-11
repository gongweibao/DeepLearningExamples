image="hub.baidubce.com/paddlepaddle/benchmark/ngc-bert:99b1"
docker pull nvcr.io/nvidia/tritonserver:20.09-py3
docker build . -t ${image}
#docker push ${image}

inter_image="registry.baidu.com/paddlepaddle-public/benchmark/ngc-bert:99b1"
docker tag ${image} ${inter_image}
#docker save > bert.tar
