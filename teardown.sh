#! /bin/bash
echo "Please wait while we reset your lab environment."

kubectl apply -f kube/fetch.yaml
pod=$(kubectl get pods -o name | grep mysql)
kubectl exec -it $pod -- bash -c "mysql --database=main --password=password -e \"DELETE FROM images WHERE id = 2;\"" &> /dev/null

echo "Done!"
