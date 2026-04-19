{{- define "myapp.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "myapp.fullname" . }}-{{ .name }}
  labels:
    {{- include "myapp.labels" . | nindent 4 }}
spec:
  type: {{ .type }}
  ports:
    - port: {{ .port }}
      targetPort: {{ .targetPort }}
      protocol: TCP
  selector:
    {{- include "myapp.selectorLabels" . | nindent 4 }}
{{- end }}
