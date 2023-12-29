export ROOT="$(pwd)"
export SCRIPTS_DIR="$ROOT/scripts"
export CONFIG_FILE="$ROOT/config.json"


source "$SCRIPTS_DIR/utils.sh"
source "$SCRIPTS_DIR/secrets.sh"
source "$SCRIPTS_DIR/kind.sh"
source "$SCRIPTS_DIR/argo.sh"


function install-system() {
  helm template "$ROOT/apps" $@ \
    | kubectl apply -f -
}