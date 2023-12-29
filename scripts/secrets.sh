SECRET_MANAGER="$(get-value 'secrets.manager')"
SECRET_MANAGER="${SECRET_MANAGER:-env}"

echo "Using secret manager '$SECRET_MANAGER'"
source "$SCRIPTS_DIR/secret-managers/$SECRET_MANAGER.sh"

function update-secrets() {
  GITHUB_USERNAME="$(get-value github.username)"
  GITHUB_PAT="$(load-secret github.pat)"
  CLOUDFLARE_API_TOKEN="$(load-secret cloudflare.apiToken)"
  CLOUDFLARE_TUNNEL_SECRET="$(load-secret cloudflare.tunnelSecret)"
  helm template $ROOT/charts/secrets \
    --set github.username="$GITHUB_USERNAME" \
    --set github.pat="$GITHUB_PAT" \
    --set cloudflare.token="$CLOUDFLARE_API_TOKEN" \
    --set cloudflare.tunnelSecret="$CLOUDFLARE_TUNNEL_SECRET" \
    | kubectl apply -f -
}