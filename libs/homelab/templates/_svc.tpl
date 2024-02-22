{{- define "homelab.svc" -}}
apiVersion: v1
kind: Service
metadata:
  name: "{{ .app }}-{{ .name }}"
spec:
  ports:
    - port: {{ .containerPort }}
      targetPort: {{ .containerPort }}
      protocol: {{ .protocol | default "TCP" }}
  selector:
    app: "{{ .app }}"
{{- end}}
