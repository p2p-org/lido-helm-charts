{{- range $kind := .Values.kinds }}
{{- with dict "Values" $.Values  "Release" $.Release "Chart" $.Chart "Kind" $kind }}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "oracle.fullname" . }}
  labels:
    {{- include "oracle.labels" . | nindent 4 }}
spec:
  type: ClusterIP
  ports:
    - port: {{ .Values.app.prometheus_port | default "9000" }}
      targetPort: http
      protocol: TCP
      name: http
    - port: {{ .Values.app.healthcheck_server_port | default "9010" }}
      targetPort: http
      protocol: TCP
      name: healthcheck
  selector:
    {{- include "oracle.selectorLabels" . | nindent 4 }}
{{- end }}
{{- end }}
