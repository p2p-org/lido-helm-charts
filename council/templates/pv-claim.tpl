{{- if .Values.cache.enabled -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "council.cacheName" . }}
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: {{ .Values.cache.storageClassName }}
  resources:
    requests:
      storage: {{ .Values.cache.size }}
{{- end }}
