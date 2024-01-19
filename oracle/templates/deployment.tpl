{{- range $kind := .Values.kinds }}
{{- with dict "Values" $.Values  "Release" $.Release "Chart" $.Chart "Kind" $kind }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "oracle.fullname" . }}
  labels:
    {{- include "oracle.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "oracle.labels" . | nindent 6 }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "oracle.labels" . | nindent 8 }}
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
          args: ["{{ .Kind }}"]
          imagePullPolicy: IfNotPresent
          {{- if .Values.volumeMounts }}
          volumeMounts:
            {{- toYaml .Values.volumeMounts | nindent 12 }}
          {{- end }}
          env:
          {{- range $key, $value := .Values.app }}
            - name: {{ $key | upper }}
              valueFrom:
                configMapKeyRef:
                  name: {{ include "oracle.fullname" $ }}
                  key: {{ $key | upper }}
          {{- end }}
            - name: EXECUTION_CLIENT_URI
              valueFrom:
                configMapKeyRef:
                  name: {{ include "oracle.fullname" $ }}
                  key: EL_NODE_RPC
            - name: CONSENSUS_CLIENT_URI
              valueFrom:
                configMapKeyRef:
                  name: {{ include "oracle.fullname" $ }}
                  key: CL_NODE_RPC
          ports:
            - name: http
              containerPort: {{ .Values.service.port | default "9000" }}
              protocol: TCP
          livenessProbe:                                                                                                                                                            
            failureThreshold: 3
            initialDelaySeconds: 5
            periodSeconds: 10
            successThreshold: 1
            tcpSocket:
              port: {{ .Values.service.port | default "9000" }}
            timeoutSeconds: 1
          readinessProbe:
            failureThreshold: 3
            initialDelaySeconds: 5
            periodSeconds: 10
            successThreshold: 1
            tcpSocket:
              port: {{ .Values.service.port | default "9000" }}
            timeoutSeconds: 1
          {{- if .Values.startupProbe }}
          startupProbe:
            httpGet:
              path: /
              port: http
            failureThreshold: {{ .Values.startupProbe.failureThreshold }}
            periodSeconds: {{ .Values.startupProbe.periodSeconds }}
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
      {{- if .Values.volumes }}
      volumes:
        {{- toYaml .Values.volumes | nindent 8 }}
      {{- end }}
{{- end }}
{{- end }}
