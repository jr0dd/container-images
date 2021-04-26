docker build -t cloudflare-ddns . --build-arg TARGETPLATFORM=linux/amd64 --build-arg VERSION=focal-20210416 --network host 

docker run -d -t -i --network host --name cloudflare-ddns cloudflare-ddns:latest 

docker tag cloudflare-ddns:latest ghcr.io/jr0dd/container-images/cloudflare-ddns:latest 

cat github_token | docker login https://ghcr.io -u jr0dd --password-stdin

docker push ghcr.io/jr0dd/container-images/cloudflare-ddns:latest
