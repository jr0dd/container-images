docker build -t cf-ddns . --build-arg TARGETPLATFORM=linux/amd64 --build-arg VERSION=focal-20210416 --network host 

docker run -d -t -i --network host --name cf-ddns cf-ddns:latest 

docker tag cf-ddns:latest ghcr.io/jr0dd/container-images/cf-ddns:latest 

cat token| docker login https://ghcr.io -u jr0dd --password-stdin

docker push ghcr.io/jr0dd/container-images/cf-ddns:latest
