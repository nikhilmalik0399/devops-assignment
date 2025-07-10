 Prerequisites

AWS CLI installed & configured: aws configure

kubectl installed

terraform installed

helm installed

Initialize & Apply Terraform

terraform init
terraform apply -auto-approve

Configure kubectl

aws eks --region ap-south-1 update-kubeconfig --name devops-eks-cluster
kubectl get nodes

Apply Manifests

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get svc nginx-service


Install ArgoCD

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Expose ArgoCD

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get svc -n argocd


Get ArgoCD Admin Password

kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 -d && echo

Install Ingress Controller (NGINX)

kubectl create namespace ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.service.type=LoadBalancer

Apply:
kubectl apply -f manifests/ingress.yaml

Route 53 DNS Record (Alias to Ingress ELB)

Go to Route 53 > Your Hosted Zone

Create new A Record with:

Name: example

Type: A

Alias: Yes

Alias Target: *.elb.amazonaws.com (Ingress External DNS)

