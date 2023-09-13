apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "ejector.fullname" . }}-test-connection"
  labels:
    {{- include "ejector.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['{{ include "ejector.fullname" . }}:{{ .Values.service.port }}']
  restartPolicy: Never
