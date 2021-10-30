#! /bin/bash
echo "Please wait while we update your lab environment."

eval $(minikube docker-env -p minikube-pixie-lab)
docker build simulator -t simulator-scenario-1

kubectl apply -f kube
pod=$(kubectl get pods -o name | grep mysql)
kubectl exec -it $pod -- bash -c "mysql --database=main --password=password -e \"INSERT INTO images VALUES (101, 'pixie', 'https://tinyhats.s3.amazonaws.com/pixie.png', 'pixie.png', 'PIXIE', 'true');\"" &> /dev/null

echo "Done!"
