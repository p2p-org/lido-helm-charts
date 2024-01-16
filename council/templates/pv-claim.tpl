{{- if .Values.cache.enabled -}}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "council.pvcCacheName" . }}
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: {{ .Values.cache.storageClassName }}
  resources:
    requests:
      storage: {{ .Values.cache.size }}
{{- end }}
