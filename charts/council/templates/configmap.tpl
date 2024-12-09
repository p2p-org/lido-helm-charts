apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "council.fullname" . }}
  labels:
    {{- include "council.labels" . | nindent 4 }}
data:
  ## --
  {{- range $key, $value := .Values.app }}
  {{ $key | upper }}: {{ $value | quote }}
  {{- end }}
  ## --
