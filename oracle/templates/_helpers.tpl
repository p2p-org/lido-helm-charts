{{/*
Expand the name of the chart.
*/}}
{{- define "oracle.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oracle.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- if .Kind -}}
{{- printf "%s-%s" .Release.Name .Kind }}
{{- else -}}
{{ .Release.Name }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "oracle.labels" -}}
{{ include "oracle.selectorLabels" . }}
app.kubernetes.io/component: oracle
{{- end }}

{{/*
Selector labels
*/}}
{{- define "oracle.selectorLabels" -}}
{{- if .Values.labels }}
{{- toYaml .Values.labels | nindent 0 }}
{{- else -}}
{{- if .Kind -}}
app.kubernetes.io/name: {{ include "oracle.name" . }}-{{ .Kind }}
{{- else -}}
app.kubernetes.io/name: {{ include "oracle.name" . }}
{{- end }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: lidofinance
{{- end }}
{{- end }}
