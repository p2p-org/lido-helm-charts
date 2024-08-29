{{- if .Values.cache.enabled -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "oracle.cacheName" . }}
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: {{ .Values.cache.storageClassName }}
  resources:
    requests:
      storage: {{ .Values.cache.size }}
{{- end }}
