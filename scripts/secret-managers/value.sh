function load-secret() {
  NAME="$1"; shift
  ITEM="$(get-value "secrets.keys.$NAME")"
  echo "$ITEM"
}