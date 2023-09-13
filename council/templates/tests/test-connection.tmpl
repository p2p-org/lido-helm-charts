apiVersion: v1
kind: Pod
metadata:
  name: "{{ include "council.fullname" . }}-test-connection"
  labels:
    {{- include "council.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['{{ include "council.fullname" . }}:{{ .Values.service.port }}']
  restartPolicy: Never
