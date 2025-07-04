{{- range $kind := .Values.kinds }}
{{- with dict "Values" $.Values  "Release" $.Release "Chart" $.Chart "Kind" $kind }}
{{- $_fullname := include "oracle.fullname" . }}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ $_fullname }}
  labels:
    {{- include "oracle.labels" . | nindent 4 }}
spec:
  type: ClusterIP
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
  selector:
    {{- include "oracle.selectorLabels" . | nindent 4 }}
{{- end }}
{{- end }}
