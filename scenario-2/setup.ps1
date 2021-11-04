echo "Please wait while we set up your lab environment.`n"

$pod=kubectl get pods -o custom-columns=":metadata.name" | findstr mysql

$query="mysql --database=main --password=password --execute=\""UPDATE images SET approve = 'false' WHERE id = 101;"""
kubectl exec -it $pod -- bash -c $query > $null
kubectl apply -f kube

echo "Done!"