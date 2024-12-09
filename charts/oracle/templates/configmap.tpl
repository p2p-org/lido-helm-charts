{{- range $kind := .Values.kinds }}
{{- with dict "Values" $.Values  "Release" $.Release "Chart" $.Chart "Kind" $kind }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "oracle.fullname" . }}
  labels:
    {{- include "oracle.labels" . | nindent 4 }}
data:
  {{- range $key, $value := index .Values.app .Kind }}
  {{ $key | upper }}: {{ $value | quote }}
  {{- end }}
{{- end }}
{{- end }}
