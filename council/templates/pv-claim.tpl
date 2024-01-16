apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "council.pvcName" . }}
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: standard-rwo
  resources:
    requests:
      storage: 1Gi
