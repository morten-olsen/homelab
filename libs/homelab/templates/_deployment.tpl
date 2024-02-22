{{- define "homelab.deployment.volumes"}}
{{- if or .volumes.data .volumes.shared }}
volumes:
{{- range $key, $value := .volumes.data }}
  - name: "data-{{$key}}"
    persistentVolumeClaim:
      claimName: "{{$.name}}-{{$key}}"
{{- end}}
{{- range $key, $value := .volumes.shared }}
  - name: "shared-{{$key}}"
    persistentVolumeClaim:
      claimName: "shared-{{$key}}"
{{- end}}
{{- end}}
{{- end}}

{{- define "homelab.deployment.volumeMounts"}}
{{- if or .volumes.data .volumes.shared }}
volumeMounts:
{{- range $key, $value := .volumes.data }}
  - name: "data-{{$key}}"
    mountPath: "{{$value.path}}"
{{- end}}
{{- range $key, $value := .volumes.shared }}
  - name: "shared-{{$key}}"
    mountPath: "{{$value.path}}"
{{- end}}
{{- end}}
{{- end}}

{{- define "homelab.deployment.ports"}}
{{- if .ingress }}
ports:
{{- range $key, $value := .ingress }}
  - containerPort: {{$value.containerPort}}
{{- end}}
{{- range $key, $value := .ports}}
  - containerPort: {{$value.containerPort}}
{{- end}}
{{- end}}
{{- end}}

{{- define "homelab.deployment.env"}}
{{- if .env }}
env:
{{- range $key, $value := .env }}
  - name: {{$key}}
    value: {{$value | quote }}
{{- end}}
{{- end}}
{{- end}}

{{- define "homelab.deployment.defaults" }}
volumes:
  data: {}
  shared: {}
{{- end}}

{{- define "homelab.deployment"}}
{{- $merged := merge (include "homelab.deployment.defaults" . | fromYaml) (deepCopy .) -}}
{{- $volumes := include "homelab.deployment.volumes" $merged }}
{{- $volumeMounts := include "homelab.deployment.volumeMounts" $merged }}
{{- $ports := include "homelab.deployment.ports" $merged }}
{{- $env := include "homelab.deployment.env" $merged }}

apiVersion: apps/v1
kind: Deployment
metadata:
  name: "{{ .name }}"
spec:
  selector:
    matchLabels:
      app: "{{ .name }}"
  replicas: 1
  template:
    metadata:
      labels:
        app: "{{ .name }}"
    spec:
      containers:
        - image: "{{ .image }}"
          imagePullPolicy: Always
          name: "{{ .name }}"
          {{$env | indent 10}}
          {{$ports | indent 10}}
          {{$volumeMounts | indent 10 }}
      {{$volumes | indent 6 }}
{{- end}}
