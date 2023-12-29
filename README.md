_THIS IS A WORK IN PROGRESS!, do not actually use_

Battery included Kubernetes setup, both self contained with kind, or releasable into actual self-hosted cluster (and at some point, hopefully even managed clusters)

The target is to create a Kubernetes setup, that can run anywhere from locally using kind, with just a few applications deployed, all the way up to thousands of applications on hundreds of nodes, with little to no additional configuration, and it should be secure by default, with best in class monitoring of both the cluster as well as the workloads

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
