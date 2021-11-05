# Pixie Lab
Follow the Lab instructions here:  
[https://developer.newrelic.com/collect-data/pixie/](https://developer.newrelic.com/collect-data/pixie/)

# Requirements for Windows Users
1. Install Hyper-V  
![Setup 1](/img/setup_01.png)
2. Use or create Virtual Switch (External)  
![Setup 2](/img/setup_02.png)
3. Download and install/add to `PATH`:
    - `kubectl.exe`
    - `minikube.exe` (rename the filename from `minikube-windows-amd64.exe`)
    - `helm.exe`
4. Use the scripts in this repository for PowerShell  
    - `main\setup.ps1`
    - `scenario-1\setup.ps1`
    - `scenario-2\setup.ps1`
5. Minor update to Pixie install script:
   - Replace `&&` with `;` to execute additional statements
   - Replace `\` with `` ` `` to continue statement on new line

## Example Pixie Install Script Modified for PowerShell
Tip: Use `CTRL + H` to Find and Replace in Notepad.
```
kubectl apply -f https://download.newrelic.com/install/kubernetes/pixie/latest/px.dev_viziers.yaml; 
kubectl apply -f https://download.newrelic.com/install/kubernetes/pixie/latest/olm_crd.yaml; 
helm repo add newrelic https://helm-charts.newrelic.com;
helm repo update; 
kubectl create namespace newrelic;

helm upgrade --install newrelic-bundle newrelic/nri-bundle `
 --set global.licenseKey=a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8NRAL `
 --set global.cluster=tiny-hat `
 --namespace=newrelic `
 --set newrelic-infrastructure.privileged=true `
 --set global.lowDataMode=true `
 --set ksm.enabled=true `
 --set prometheus.enabled=true `
 --set kubeEvents.enabled=true `
 --set logging.enabled=true `
 --set newrelic-pixie.enabled=true `
 --set newrelic-pixie.apiKey=px-api-a1b2c3d4-e5f6-g7h8-i9j0-k1l2m3n4o0p5 `
 --set pixie-chart.enabled=true `
 --set pixie-chart.deployKey=px-dep-d4c3b2a1-f6e5-h8g7-j0i9-p5o0n4m3l2k1 `
 --set pixie-chart.clusterName=tiny-hat
 ```
 