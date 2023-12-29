export ARGO_NAMESPACE="argocd"

function install-argo() {
  helm repo add argo-cd https://argoproj.github.io/argo-helm
  helm dependency build "$ROOT/charts/system/argo-cd"
  helm install \
    --namespace "$ARGO_NAMESPACE" \
    --create-namespace \
    --wait argo-cd "$ROOT/charts/system/argo-cd"
}

function get-argo-password() {
  kubectl -n "$ARGO_NAMESPACE" get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | wl-copy
}

function forward-argo() {
  get-argo-password
  kubectl -n "$ARGO_NAMESPACE" port-forward svc/argo-cd-argocd-server 8080:443
}