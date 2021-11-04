echo "Please wait while we set up your lab environment.`n"

echo "=== Checking your dependencies ==="

$error.clear()
try { minikube version > $null }
catch { "Error occured" }
if (!$error) { "minikube ✓" } else { echo "Please install minikube" }

$error.clear()
try { kubectl version --client=true > $null }
catch { "not found" }
if (!$error) { "kubectl ✓" } else { echo "Please install kubectl" }

$hyperv = Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online
if ($hyperv.State -eq "Enabled") { "Hyper-V ✓" } else { echo "Please install Hyper-V or Start Hyper-V Manager Service" }

if ((Get-VMSwitch | findstr -i external) -eq $null) { "Please create an External Hyper-V Switch" } else { echo "Hyper-V External Switch ✓" }

$error.clear()
try { helm version > $null }
catch { "Error occured" }
if (!$error) { "helm ✓" } else { echo "Please install helm" }

echo "`n=== Spinning up your cluster ==="

# 8000 MB memory is not enough on Windows and 4 CPUs runs a bit slow
minikube start --driver=hyperv --hyperv-virtual-switch='New Virtual Switch' --cni=flannel --cpus=6 --memory=10000 -p minikube-pixie-lab
kubectl apply -f kube