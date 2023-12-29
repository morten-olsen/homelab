function load-secret() {
  NAME="$1"; shift
  ITEM="$(get-value "secrets.keys.$NAME")"
  ITEM_NAME="$(echo $ITEM | jq -r '.name')"
  ITEM_FIELD="$(echo $ITEM | jq -r '.field')"
  ITEM_VAULT="$(echo $ITEM | jq -r '.vault')"

  ITEM="$(op item get "$ITEM_NAME" --vault "$ITEM_VAULT" --format json)"
  if [ -z "$ITEM" ]; then
    echo "ERROR: Key '$PATH' not found in $SECRET_FILE"
    exit 1
  fi
  SECRET="$(echo $ITEM | jq ".fields[] | select(.id == \"$ITEM_FIELD\") | .value" -r)"
  echo $SECRET
}