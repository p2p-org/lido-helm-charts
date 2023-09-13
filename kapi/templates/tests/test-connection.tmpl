apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "kapi.fullname" . }}-test-connection"
  labels:
    {{- include "kapi.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['{{ include "kapi.fullname" . }}:{{ .Values.service.port }}']
  restartPolicy: Never
