_THIS IS A WORK IN PROGRESS!, do not actually use_

Battery included Kubernetes setup, both self contained with kind, or releasable into actual self-hosted cluster (and at some point, hopefully even managed clusters)

This is my personal homelab setup, so it may not actually be something you want to use, unless you agree with all my choices!


```
deployment: argo-cd
updating: renovate
load-balancer: metallb
ingress: ingress-nginx
certificates: cert-manager
storage: nfs-subdir-external-provisioner
```

**Requirements**:

```
- nix
- Docker
- jq
- CloudFlare hosted domain (optional)
```

Usage:

```bash
nix develop --impure
setup-kind
get-argo-password
forward-argo

# Go to http://localhost:8080 and login with "admin"
```

**TODO:**

- [ ] Network security
- [ ] Istio ingress (?)
- Add management
  - [ ] OpenTelemetry
  - [ ] SigNoz
  - [ ] Ntfy

```
docker inspect homelab-control-plane | jq '.[0].NetworkSettings.Networks.kind'
```
