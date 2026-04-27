{{- if .Values.performanceSidecars.enabled }}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "oracle.fullname" . }}-performance-web
  labels:
    app.kubernetes.io/name: {{ include "oracle.name" . }}-performance-web
    app.kubernetes.io/instance: {{ .Release.Name }}
    app.kubernetes.io/part-of: lidofinance
    app.kubernetes.io/component: performance-web
spec:
  type: ClusterIP
  ports:
    - port: 9020
      targetPort: http
      protocol: TCP
      name: http
  selector:
    app.kubernetes.io/name: {{ include "oracle.name" . }}-performance-web
    app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
