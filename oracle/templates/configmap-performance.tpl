{{- if .Values.performanceSidecars.enabled }}
{{- $_fullname := include "oracle.fullname" . }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $_fullname }}-performance-collector
  labels:
    {{- include "oracle.labels" . | nindent 4 }}
data:
  {{- range $key, $value := .Values.performanceSidecars.collector }}
  {{- if ne $key "resources" }}
  {{ $key | upper }}: {{ $value | quote }}
  {{- end }}
  {{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $_fullname }}-performance-web
  labels:
    {{- include "oracle.labels" . | nindent 4 }}
data:
  {{- range $key, $value := .Values.performanceSidecars.web }}
  {{- if ne $key "resources" }}
  {{ $key | upper }}: {{ $value | quote }}
  {{- end }}
  {{- end }}
{{- end }}
