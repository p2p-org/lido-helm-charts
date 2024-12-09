apiVersion: v1
kind: Service
metadata:
  name: {{ include "ejector.fullname" . }}
  labels:
    {{- include "ejector.labels" . | nindent 4 }}
    {{- with .Values.service.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      {{- if .Values.service.targetPort }}
      targetPort: {{ .Values.service.targetPort  }}
      {{- end }}
      protocol: TCP
      name: http
  selector:
    {{- include "ejector.labels" . | nindent 4 }}
