{{- define "homelab.test.app" }}
test: hello
name: jesper
image: alpine
domain: foo
gateway: foobar
storageClassName: local-path
volumes:
  data:
    foo:
      path: /data/foo
ingress:
  bar:
    containerPort: 80
    subdomain: bar
namespace: testing
{{- end }}
{{- include "homelab.app" (include "homelab.test.app" . | fromYaml) }}
