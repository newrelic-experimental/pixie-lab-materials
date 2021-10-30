#! /bin/bash
echo "Please wait while we update your lab environment."

eval $(minikube docker-env -p minikube-pixie-lab)
docker build simulator -t simulator-scenario-2

pod=$(kubectl get pods -o name | grep mysql)
kubectl exec -it $pod -- bash -c "mysql --database=main --password=password -e \"UPDATE images SET approve = 'false' WHERE id = 101;\"" &> /dev/null
kubectl apply -f kube

echo "Done!"
