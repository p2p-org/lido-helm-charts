apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "kapi.fullname" . }}
  labels:
    {{- include "kapi.labels" . | nindent 4 }}
data:
  ## --
  {{- range $key, $value := .Values.app }}
  {{ $key | upper }}: {{ $value | quote }}
  {{- end }}
  ## --
