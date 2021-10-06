#! /bin/bash
echo "Please wait while we update your lab environment."

kubectl apply -f kube/fetch-2.yaml
pod=$(kubectl get pods -o name | grep mysql)
kubectl exec -it $pod -- bash -c "mysql --database=main --password=password -e \"INSERT INTO images VALUES (2, 'pixie', 'https://tinyhats.s3.amazonaws.com/pixie.png', 'pixie.png', 'PIXIE', 'true');\"" &> /dev/null

echo "Done!"
