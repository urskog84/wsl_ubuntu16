
# Docker-ce install in WSL2

## install steps
```
wsl -e apt install -y --no-install-recommends install apt-transport-https ca-certificates curl software-properties-common
wsl -e curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -


wsl -e add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu (lsb_release -cs) stable"
wsl -e apt update
wsl -e apt-cache policy docker-ce
wsl -e apt install -y docker-ce
```

## vaidate steps
```
wsl -e docker --version
wsl -e servce docker enable
wsl -e service docker start 
wsl -e docker run hello-world
```