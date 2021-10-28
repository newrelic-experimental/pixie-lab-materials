#! /bin/bash
echo -e "Please wait while we set up your lab environment.\n"

echo "=== Checking your dependencies ==="
if command -v minikube &> /dev/null
then
    echo -e "minikube \xE2\x9C\x94"
else
    echo "Please install minikube"
    exit
fi

if command -v kubectl &> /dev/null
then
    echo -e "kubectl \xE2\x9C\x94"
else
    echo "Please install kubectl"
    exit
fi

if command -v hyperkit &> /dev/null
then
    echo -e "hyperkit \xE2\x9C\x94"
else
    echo "Please install hyperkit"
    exit
fi

if command -v helm &> /dev/null
then
    echo -e "helm \xE2\x9C\x94"
else
    echo "Please install helm"
    exit
fi

echo -e "\n=== Spinning up your cluster ==="
minikube start --driver=hyperkit --cni=flannel --cpus=4 --memory=8000 -p minikube-pixie-lab
eval $(minikube docker-env -p minikube-pixie-lab)
docker build simulator -t simulator
kubectl apply -f kube
