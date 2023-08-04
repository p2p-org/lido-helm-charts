apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "ejector.fullname" . }}
  labels:
    {{- include "ejector.labels" . | nindent 4 }}
data:
  ## --
  {{- range $key, $value := .Values.app }}
  {{ $key | upper }}: {{ $value | quote }}
  {{- end }}
  ## --
