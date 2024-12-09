apiVersion: v1
kind: Service
metadata:
  name: {{ include "council.fullname" . }}
  labels:
    {{- include "council.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
  selector:
    {{- include "council.selectorLabels" . | nindent 4 }}
