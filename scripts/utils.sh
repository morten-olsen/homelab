function get-value() {
  NAME="$1"; shift
  VALUE="$(jq -r ".$NAME" $CONFIG_FILE)"
  echo $VALUE
}

function get-ns-domain() {
  NAMESPACE="$1"; shift
  kubectl get ns "$NAMESPACE" -o json | jq '.metadata.annotations.domain'
}