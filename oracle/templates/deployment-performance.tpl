{{- if .Values.performanceSidecars.enabled }}
{{- $_fullname := include "oracle.fullname" . }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ $_fullname }}-performance-collector
  labels:
    app.kubernetes.io/name: {{ include "oracle.name" . }}-performance-collector
    app.kubernetes.io/instance: {{ .Release.Name }}
    app.kubernetes.io/part-of: lidofinance
    app.kubernetes.io/component: performance-collector
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app.kubernetes.io/name: {{ include "oracle.name" . }}-performance-collector
      app.kubernetes.io/instance: {{ .Release.Name }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        app.kubernetes.io/name: {{ include "oracle.name" . }}-performance-collector
        app.kubernetes.io/instance: {{ .Release.Name }}
        app.kubernetes.io/part-of: lidofinance
        app.kubernetes.io/component: performance-collector
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
        - name: performance-collector
          {{- if .Values.securityContext }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          {{- end }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          args: ["performance_collector"]
          imagePullPolicy: IfNotPresent
          {{- with .Values.extraEnv }}
          env:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          envFrom:
            - configMapRef:
                name: {{ $_fullname }}-performance-collector
          ports:
            - name: metrics
              containerPort: 9000
              protocol: TCP
            - name: health
              containerPort: 9010
              protocol: TCP
          livenessProbe:
            tcpSocket:
              port: 9000
            failureThreshold: 3
            initialDelaySeconds: 5
            periodSeconds: 10
            timeoutSeconds: 2
          resources:
            {{- toYaml .Values.performanceSidecars.collector.resources | nindent 12 }}
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
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ $_fullname }}-performance-web
  labels:
    app.kubernetes.io/name: {{ include "oracle.name" . }}-performance-web
    app.kubernetes.io/instance: {{ .Release.Name }}
    app.kubernetes.io/part-of: lidofinance
    app.kubernetes.io/component: performance-web
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app.kubernetes.io/name: {{ include "oracle.name" . }}-performance-web
      app.kubernetes.io/instance: {{ .Release.Name }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        app.kubernetes.io/name: {{ include "oracle.name" . }}-performance-web
        app.kubernetes.io/instance: {{ .Release.Name }}
        app.kubernetes.io/part-of: lidofinance
        app.kubernetes.io/component: performance-web
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
        - name: performance-web
          {{- if .Values.securityContext }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          {{- end }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          args: ["performance_web_server"]
          imagePullPolicy: IfNotPresent
          {{- with .Values.extraEnv }}
          env:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          envFrom:
            - configMapRef:
                name: {{ $_fullname }}-performance-web
          ports:
            - name: http
              containerPort: 9020
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /health
              port: http
            failureThreshold: 3
            initialDelaySeconds: 5
            periodSeconds: 10
            timeoutSeconds: 2
          resources:
            {{- toYaml .Values.performanceSidecars.web.resources | nindent 12 }}
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
{{- end }}
