echo "Please wait while we set up your lab environment.`n"
kubectl apply -f kube
$pod=kubectl get pods -o custom-columns=":metadata.name" | findstr mysql
$query="mysql --database=main --password=password --execute=\""insert into images values (101, 'pixie', 'https://tinyhats.s3.amazonaws.com/pixie.png', 'pixie.png', 'PIXIE', 'true');"""
kubectl exec -it $pod -- bash -c $query > $null
echo "Done!"