apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "kapi.fullname" . }}
  labels:
    {{- include "kapi.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "kapi.labels" . | nindent 6 }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "kapi.labels" . | nindent 8 }}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- if .Values.podSecurityContext }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      {{- end }}
      containers:
        - name: {{ .Chart.Name }}
          {{- if .Values.securityContext }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          {{- end }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: IfNotPresent
          volumeMounts:
          {{- if .Values.volumeMounts }}
            {{- toYaml .Values.volumeMounts | nindent 12 }}
          {{- end }}
            - mountPath: /.cache/yarn
              name: tmp
              subPath: tmp
            - mountPath: /.yarn
              name: tmp
              subPath: tmp
          env:
          {{- range $key, $value := .Values.app }}
            - name: {{ $key | upper }}
              valueFrom:
                configMapKeyRef:
                  name: {{ include "kapi.fullname" $ }}
                  key: {{ $key | upper }}
          {{- end }}
            - name: PROVIDERS_URLS
              valueFrom:
                configMapKeyRef:
                  name: {{ include "kapi.fullname" $ }}
                  key: EL_NODE_RPC
            - name: CL_API_URLS
              valueFrom:
                configMapKeyRef:
                  name: {{ include "kapi.fullname" $ }}
                  key: CL_NODE_RPC
          ports:
            - name:  http
              containerPort: {{ .Values.service.targetPort }}
              protocol: TCP
          {{- if .Values.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.readinessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.startupProbe }}
          startupProbe:
            {{- toYaml .Values.startupProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.resources}}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          {{- end }}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      volumes:
      {{- if .Values.volumes }}
        {{- toYaml .Values.volumes | nindent 8 }}
      {{- end }}
        - name: tmp
          emptyDir:
            medium: Memory
            sizeLimit: 1024Mi
