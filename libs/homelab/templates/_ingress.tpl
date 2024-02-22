{{- define "homelab.ingress" }}
{{- include "homelab.svc" . }}
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: "{{ .app }}-{{ .name }}"
spec:
  hosts:
  - "{{ .subdomain }}.{{ .domain }}"
  - "{{ .subdomain }}-internal.{{ .domain }}"
  gateways:
  - "{{ .gateway }}"
  http:
  - route:
    - destination:
        host: "{{ .app }}-{{ .name }}.{{ .namespace }}.svc.cluster.local"
        port:
          number: {{ .port }}
---
{{- end }}
