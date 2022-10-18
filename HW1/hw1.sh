#install sysbench on qemu
sudo apt update
sudo apt install sysbench

#install ubuntu on docker
docker pull ubuntu

#run container on docker
docker pull centos
docker run -d -it --name=ziyan centos
docker ps
docker exec -it ziyan /bin/bash

#docker image
docker image ls

#cpu test on qemu
sysbench –test=cpu --cpu-max-prime=25000 run

#cpu test on docker
docker run zyclonite/sysbench:latest sysbench --test=cpu --cpu-max-prime=25000 run

#io test on qemu
sysbench --num-threads=16 --test=fileio --file-total-size=10G --file-test-mode=rndrw prepare
sysbench --num-threads=16 --test=fileio --file-total-size=10G --file-test-mode=rndrw run
sysbench --num-threads=16 --test=fileio --file-total-size=10G --file-test-mode=rndrw cleanup

#io test on docker
docker run --rm \
    -v `pwd`/workdir:/root/workdir \
     zyclonite/sysbench:latest \
    /root/results/output_fileio.prof \
    --test=fileio \
    --file-num=64 \
    --file-test-mode=rndrw \
    prepare
 