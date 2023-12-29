export KIND_NAME=${KIND_NAME:-"homelab"}

function setup-kind() {
  echo "Setting up kind"
  delete-kind
  kind create cluster --name "$KIND_NAME" --config $ROOT/kind-config.yaml
  # helm repo add projectcalico https://docs.tigera.io/calico/charts
  # helm install calico projectcalico/tigera-operator \
  #   --version v3.27.0 \
  #   -f "$ROOT/calico.yaml" \
  #   --namespace tigera-operator \
  #   --create-namespace \
  #   --wait
  # kubectl -n kube-system set env daemonset/calico-node FELIX_IGNORELOOSERPF=true
  update-secrets
  install-argo
  install-system $@
}

function delete-kind() {
  echo "Deleting existing kind"
  kind delete cluster --name "$KIND_NAME"
}